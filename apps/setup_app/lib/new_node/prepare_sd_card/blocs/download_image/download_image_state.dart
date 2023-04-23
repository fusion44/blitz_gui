part of 'download_image_bloc.dart';

@immutable
abstract class DlImageBaseState extends Equatable {}

@immutable
class DlImageInitial extends DlImageBaseState {
  @override
  List<Object> get props => [];
}

@immutable
class DlImageFileExistsErrorState extends DlImageBaseState {
  final DlFile id;
  final String filePath;
  final String path;

  DlImageFileExistsErrorState(this.id, this.filePath, this.path);

  @override
  List<Object> get props => [id, filePath, path];
}

@immutable
class DlImageStartedState extends DlImageBaseState {
  final DlFile dlFile;

  DlImageStartedState(this.dlFile);

  @override
  List<Object> get props => [dlFile];
}

@immutable
class DlImageProgressState extends DlImageBaseState {
  final List<FileData> files;

  DlImageProgressState(this.files);

  @override
  List<Object> get props => [...files];
}

@immutable
class DlImageCanceledState extends DlImageBaseState {
  @override
  List<Object> get props => [];
}

@immutable
class DlImageAllFinishedState extends DlImageBaseState {
  final List<FileData> files;

  DlImageAllFinishedState(this.files);

  @override
  List<Object> get props => [...files];
}

@immutable
class DlImageErrorState extends DlImageBaseState {
  final String message;

  DlImageErrorState(this.message);

  @override
  List<Object> get props => [message];
}
