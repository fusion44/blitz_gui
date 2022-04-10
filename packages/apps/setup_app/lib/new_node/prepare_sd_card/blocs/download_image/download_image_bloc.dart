import 'dart:io' as io;

import 'package:flutter/cupertino.dart';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../models/file_data.dart';

part 'download_image_event.dart';
part 'download_image_state.dart';

class DlImageBloc extends Bloc<DlImageBaseEvent, DlImageBaseState> {
  CancelToken? _cancelToken;
  DateTime _lastUpdate = DateTime.now();
  final _files = <DlFile, FileData>{
    DlFile.pubKey: FileData(
      DlFile.pubKey,
      '${io.Directory.systemTemp.path}/pgp_keys.asc',
      'https://keybase.io/rootzoll/pgp_keys.asc',
      'pgp_keys.asc',
    ),
    DlFile.image: FileData(
      DlFile.image,
      '${io.Directory.systemTemp.path}/raspiblitz-v1.7.2-2022-02-20.img.gz',
      'https://raspiblitz.fulmo.org/images/raspiblitz-v1.7.2-2022-02-20.img.gz',
      'raspiblitz-v1.7.2-2022-02-20.img.gz',
    ),
    DlFile.etcher: FileData(
      DlFile.etcher,
      '${io.Directory.systemTemp.path}/balenaEtcher-1.5.120-x64.AppImage',
      'https://github.com/balena-io/etcher/releases/download/v1.5.120/balenaEtcher-1.5.120-x64.AppImage',
      'balenaEtcher-1.5.120-x64.AppImage',
    ),
  };

  DlImageBloc() : super(DlImageInitial()) {
    on<StartDlEvent>((event, emit) async {
      emit(DlImageProgressState(_files.values.toList()));
      for (var k in _files.keys) {
        final f = _files[k];
        if (f == null) throw StateError('File $k cannot be null');
        _files[k] = f.copyWith(status: DlFileStatus.downloading);

        final exists = await io.File(f.path).exists();
        if (exists && !event.overwrite) {
          emit(DlImageFileExistsErrorState(f.id, f.path, f.url));
          continue;
        }

        try {
          await Dio().download(
            f.url,
            f.path,
            cancelToken: _cancelToken,
            onReceiveProgress: (a, b) => _progressUpdate(a, b, f),
          );
          _files[k] = f.copyWith(status: DlFileStatus.finished);
        } catch (e) {
          _cancelToken?.cancel();
          _cancelToken = null;
          emit(DlImageErrorState(e.toString()));
          debugPrint(e.toString());
          return;
        }
      }

      bool verified = await _verifyDownloads();

      if (verified) {
        emit(DlImageAllFinishedState(_files.values.toList()));
      } else {
        emit(DlImageErrorState('Unable to verify downloads'));
      }
    });

    on<CancelDlImageEvent>((event, emit) {
      try {
        _cancelToken?.cancel();
      } on DioError catch (e) {
        if (e.type == DioErrorType.cancel) {
          // ignore
        } else {
          emit(DlImageErrorState(e.toString()));
          rethrow;
        }
      }
      _cancelToken = null;
      emit(DlImageCanceledState());
    });

    on<_UpdateDlProgressEvent>((event, emit) {
      var perc = (100 / event.total) * event.downloaded;
      final a = (event.downloaded / 1024 / 1024).floor();
      final b = (event.total / 1024 / 1024).floor();
      _files[event.dlFile] = _files[event.dlFile]!.copyWith(
        downloadedMiB: a,
        totalMiB: b,
        percent: perc,
      );
      emit(DlImageProgressState(_files.values.toList()));
    });
  }

  void _progressUpdate(int current, int total, FileData file) {
    final n = DateTime.now();
    if (_lastUpdate.difference(n).inMilliseconds < -1000) {
      add(_UpdateDlProgressEvent(file.id, current, total));
      _lastUpdate = n;
    }
  }

  Future<bool> _verifyDownloads() async {
    // TODO actually verify the downloads
    return true;
  }
}
