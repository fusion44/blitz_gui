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

  factory BitcoinCoreStatusUpdate.fromContainer(BitcoinCoreContainer c) =>
      BitcoinCoreStatusUpdate(c.status, c.name, c.image, c.dataPath);

  @override
  String toString() =>
      'BitcoinCoreStatusUpdate: ${status.status} / ${status.message} / $name';
}
