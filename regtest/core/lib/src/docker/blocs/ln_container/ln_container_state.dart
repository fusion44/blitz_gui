part of 'ln_container_bloc.dart';

@immutable
abstract class LnContainerState {}

class LnStatusUpdate extends LnContainerState {
  final ContainerStatusMessage status;
  final String name;
  final String image;
  final String workDir;

  LnStatusUpdate(this.status, this.name, this.image, this.workDir);

  factory LnStatusUpdate.fromContainer(String containerId) {
    final c = NetworkManager().findContainerById<LnContainer>(containerId);

    if (c == null) {
      throw StateError('LnContainer with ID $containerId not found');
    }

    return LnStatusUpdate(c.status, c.containerName, c.image, c.dataPath);
  }

  @override
  String toString() =>
      'LndStatusUpdate: ${status.status} / ${status.message} / $name';
}
