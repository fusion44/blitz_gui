part of 'lnd_container_bloc.dart';

@immutable
abstract class LndContainerState {}

class LndStatusUpdate extends LndContainerState {
  final ContainerStatusMessage status;
  final String name;
  final String image;
  final String workDir;

  LndStatusUpdate(this.status, this.name, this.image, this.workDir);

  factory LndStatusUpdate.fromContainer(String containerId) {
    final c = NetworkManager().findContainerById<LndContainer>(containerId);

    if (c == null) {
      throw StateError('LndContainer with ID $containerId not found');
    }

    return LndStatusUpdate(c.status, c.name, c.image, c.dataPath);
  }

  @override
  String toString() =>
      'LndStatusUpdate: ${status.status} / ${status.message} / $name';
}
