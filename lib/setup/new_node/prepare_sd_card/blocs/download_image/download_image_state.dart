part of 'download_image_bloc.dart';

@immutable
abstract class DlFilesState extends Equatable {}

@immutable
class DlFilesInitial extends DlFilesState {
  @override
  List<Object> get props => [];
}

@immutable
class DlFilesErrorFileExistsState extends DlFilesState {
  final DlFile dlFile;
  final String path;

  DlFilesErrorFileExistsState(this.dlFile, this.path);

  @override
  List<Object> get props => [dlFile, path];
}

@immutable
class DlFileStartState extends DlFilesState {
  final DlFile dlFile;

  DlFileStartState(this.dlFile);

  @override
  List<Object> get props => [dlFile];
}

@immutable
class DlFileProgressState extends DlFilesState {
  final int downloadedMiB;
  final int totalMiB;
  final double percent;

  DlFileProgressState(this.downloadedMiB, this.totalMiB, this.percent);

  @override
  List<Object> get props => [downloadedMiB, totalMiB, percent];
}

@immutable
class DlFileCanceledState extends DlFilesState {
  @override
  List<Object> get props => [];
}

@immutable
class DlFileAllFinishedState extends DlFilesState {
  final String imagePath;
  final String etcherPath;

  DlFileAllFinishedState(this.imagePath, this.etcherPath);

  @override
  List<Object> get props => [];
}

@immutable
class DlFileErrorState extends DlFilesState {
  final String message;

  DlFileErrorState(this.message);

  @override
  List<Object> get props => [message];
}
