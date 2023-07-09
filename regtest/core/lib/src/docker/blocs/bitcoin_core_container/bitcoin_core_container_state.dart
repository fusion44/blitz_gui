part of 'bitcoin_core_container_bloc.dart';

@immutable
abstract class BitcoinCoreContainerState {}

class BitcoinCoreContainerInitial extends BitcoinCoreContainerState {}

class BitcoinCoreStatusUpdate extends BitcoinCoreContainerState {
  final ContainerStatusMessage status;
  final String name;
  final String image;
  final String workDir;

  BitcoinCoreStatusUpdate(this.status, this.name, this.image, this.workDir);

  factory BitcoinCoreStatusUpdate.fromContainer(String containerId) {
    final c = NetworkManager().findContainerById<BitcoinCoreContainer>(
      containerId,
    );

    if (c == null) {
      throw StateError('BitcoinCoreContainer with ID $containerId not found');
    }

    return BitcoinCoreStatusUpdate(
      c.status,
      c.containerName,
      c.image,
      c.dataPath,
    );
  }

  @override
  String toString() =>
      'BitcoinCoreStatusUpdate: ${status.status} / ${status.message} / $name';
}
