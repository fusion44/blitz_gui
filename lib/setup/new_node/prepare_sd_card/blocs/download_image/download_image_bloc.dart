import 'dart:async';
import 'dart:io' as io;

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'download_image_event.dart';
part 'download_image_state.dart';

enum DlFile { pubKey, image, etcher }

class DlImageBloc extends Bloc<DownloadImageBaseEvent, DlFilesState> {
  static const _dlRoot = 'https://raspiblitz.fulmo.org/images';
  final _dlFolder = io.Directory.systemTemp.path;

  CancelToken? _imageCancelToken;
  CancelToken? _etcherCancelToken;

  String _dlImgPath = '';
  String _dlEtcherPath = '';

  DlImageBloc() : super(DlFilesInitial());

  @override
  Stream<DlFilesState> mapEventToState(DownloadImageBaseEvent event) async* {
    if (event is StartDlEvent) {
      if (event.dlFile == DlFile.pubKey) {
        yield DlFileStartState(DlFile.pubKey);

        try {
          _doDownloadPubKey();
        } catch (e) {
          yield DlFileErrorState(e.toString());
          print(e);
          return;
        }
      } else if (event.dlFile == DlFile.image) {
        const imgUrl = '$_dlRoot/raspiblitz-v1.7.0-2021-04-25.img.gz';
        _dlImgPath = '$_dlFolder/raspiblitz-v1.7.0-2021-04-25.img.gz';

        // Check if file exists
        final imgFileExists = await io.File(_dlImgPath).exists();
        if (imgFileExists && !event.overwrite) {
          yield DlFilesErrorFileExistsState(event.dlFile, _dlImgPath);
          return;
        }

        // Tell client to that download is about to state
        yield DlFileStartState(DlFile.image);

        // Download the image
        _imageCancelToken?.cancel();
        try {
          _imageCancelToken = CancelToken();
          _doDownloadImageFile(imgUrl, _dlImgPath);
        } catch (e) {
          _imageCancelToken?.cancel();
          _imageCancelToken = null;
          yield DlFileErrorState(e.toString());
          print(e);
        }
      } else if (event.dlFile == DlFile.etcher) {
        // Check if Etcher file exists
        _dlEtcherPath = '$_dlFolder/balenaEtcher-1.5.120-x64.AppImage';
        const dlEtcherUrl =
            'https://github.com/balena-io/etcher/releases/download/v1.5.120/balenaEtcher-1.5.120-x64.AppImage';
        final etcherFileExists = await io.File(_dlEtcherPath).exists();
        if (etcherFileExists && !event.overwrite) {
          yield DlFilesErrorFileExistsState(DlFile.etcher, _dlEtcherPath);
          return;
        }

        // Tell client that the download is about to start
        yield DlFileStartState(DlFile.etcher);

        // Download the image
        _etcherCancelToken?.cancel();
        try {
          _etcherCancelToken = CancelToken();
          _doDownloadEtcher(dlEtcherUrl, _dlEtcherPath);
        } catch (e) {
          _etcherCancelToken?.cancel();
          _etcherCancelToken = null;
          yield DlFileErrorState(e.toString());
          print(e);
        }
      }
    } else if (event is _VerifyDownloadsEvent) {
      // TODO: verify downloads
      yield DlFileAllFinishedState(_dlImgPath, _dlEtcherPath);
    } else if (event is CancelDlImageEvent) {
      try {
        _imageCancelToken?.cancel();
        _etcherCancelToken?.cancel();
      } on DioError catch (e) {
        if (e.type == DioErrorType.cancel) {
          // ignore
        } else {
          yield DlFileErrorState(e.toString());
          rethrow;
        }
      }
      _imageCancelToken = null;
      yield DlFileCanceledState();
    } else if (event is _UpdateDlProgressEvent) {
      var perc = (100 / event.total) * event.downloaded;
      final a = (event.downloaded / 1024 / 1024).floor();
      final b = (event.total / 1024 / 1024).floor();
      yield DlFileProgressState(a, b, perc);
    } else if (event is _DlFinishedEvent) {
      if (event.dlFile == DlFile.pubKey) {
        // PubKey done -> Dl image
        add(StartDlEvent(dlFile: DlFile.image));
      } else if (event.dlFile == DlFile.image) {
        // Image done -> Dl etcher
        add(StartDlEvent(dlFile: DlFile.etcher));
      } else if (event.dlFile == DlFile.etcher) {
        // All downloads done - Verify
        add(_VerifyDownloadsEvent());
      }
    }
  }

  void _doDownloadPubKey() async {
    const rootzollPubKeyUrl = 'https://keybase.io/rootzoll/pgp_keys.asc';
    final rootzollPubKeyPath = '$_dlFolder/pgp_keys.asc';
    await Dio().download(rootzollPubKeyUrl, rootzollPubKeyPath);
    add(_DlFinishedEvent(DlFile.pubKey));
  }

  void _doDownloadImageFile(String imgUrl, String dlImgPath) async {
    await Dio().download(
      imgUrl,
      dlImgPath,
      cancelToken: _imageCancelToken,
      onReceiveProgress: _progressUpdate,
    );
    add(_DlFinishedEvent(DlFile.image));
  }

  void _doDownloadEtcher(String fileUrl, String dlPath) async {
    await Dio().download(
      fileUrl,
      dlPath,
      cancelToken: _imageCancelToken,
      onReceiveProgress: _progressUpdate,
    );
    add(_DlFinishedEvent(DlFile.etcher));
  }

  void _progressUpdate(int current, int total) {
    add(_UpdateDlProgressEvent(current, total));
  }
}
