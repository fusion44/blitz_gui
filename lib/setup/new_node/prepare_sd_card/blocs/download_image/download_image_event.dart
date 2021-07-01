part of 'download_image_bloc.dart';

@immutable
class DownloadImageBaseEvent extends Equatable {
  @override
  List<Object> get props => [];
}

@immutable
class StartDlEvent extends DownloadImageBaseEvent {
  final DlFile dlFile;
  final String version;
  final bool overwrite;

  StartDlEvent({
    this.dlFile = DlFile.pubKey,
    this.version = '',
    this.overwrite = false,
  });

  @override
  List<Object> get props => [dlFile, version, overwrite];
}

@immutable
class CancelDlImageEvent extends DownloadImageBaseEvent {}

@immutable
class _UpdateDlProgressEvent extends DownloadImageBaseEvent {
  final int downloaded;
  final int total;

  _UpdateDlProgressEvent(this.downloaded, this.total);

  @override
  List<Object> get props => [downloaded, total];
}

@immutable
class _DlFinishedEvent extends DownloadImageBaseEvent {
  final DlFile dlFile;

  _DlFinishedEvent(this.dlFile);

  @override
  List<Object> get props => [dlFile];
}

@immutable
class _VerifyDownloadsEvent extends DownloadImageBaseEvent {
  @override
  List<Object> get props => [];
}
