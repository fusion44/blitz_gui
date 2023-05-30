part of 'bitcoin_core_container_bloc.dart';

@immutable
abstract class BitcoinCoreContainerEvent {}

class StartBitcoinCoreContainerEvent extends BitcoinCoreContainerEvent {}

class StopBitcoinCoreContainerEvent extends BitcoinCoreContainerEvent {}

class _BitcoinCoreStatusUpdate extends BitcoinCoreContainerEvent {
  final ContainerStatusMessage status;

  _BitcoinCoreStatusUpdate(this.status);
}
