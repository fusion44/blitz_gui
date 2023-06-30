part of 'blitz_api_container_bloc.dart';

@immutable
abstract class BlitzApiContainerState {}

class BlitzApiContainerInitial extends BlitzApiContainerState {}

class BlitzApiStatusUpdate extends BlitzApiContainerState {
  final ContainerStatusMessage status;
  final String name;
  final String image;
  final String workDir;

  BlitzApiStatusUpdate(this.status, this.name, this.image, this.workDir);

  factory BlitzApiStatusUpdate.fromContainer(String containerId) {
    final c = NetworkManager().findContainerById<BlitzApiContainer>(
      containerId,
    );

    if (c == null) {
      throw StateError('BlitzApiContainer with ID $containerId not found');
    }

    return BlitzApiStatusUpdate(c.status, c.name, c.image, c.dataPath);
  }

  @override
  String toString() =>
      'BlitzApiStatusUpdate: ${status.status} / ${status.message} / $name';
}
