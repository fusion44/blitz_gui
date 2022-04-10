part of 'download_image_bloc.dart';

@immutable
class DlImageBaseEvent extends Equatable {
  @override
  List<Object> get props => [];
}

@immutable
class StartDlEvent extends DlImageBaseEvent {
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
class CancelDlImageEvent extends DlImageBaseEvent {}

@immutable
class _UpdateDlProgressEvent extends DlImageBaseEvent {
  final DlFile dlFile;
  final int downloaded;
  final int total;

  _UpdateDlProgressEvent(this.dlFile, this.downloaded, this.total);

  @override
  List<Object> get props => [dlFile, downloaded, total];
}
