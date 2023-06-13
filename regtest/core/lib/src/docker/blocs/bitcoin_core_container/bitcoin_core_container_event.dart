part of 'bitcoin_core_container_bloc.dart';

@immutable
abstract class BitcoinCoreContainerEvent {}

class StartBitcoinCoreContainerEvent extends BitcoinCoreContainerEvent {}

class SettingsUpdatedEvent extends BitcoinCoreContainerEvent {
  final BitcoinCoreOptions options;

  SettingsUpdatedEvent(this.options);
}

class StopBitcoinCoreContainerEvent extends BitcoinCoreContainerEvent {}

class DeleteBitcoinCoreContainerEvent extends BitcoinCoreContainerEvent {}

class _BitcoinCoreStatusUpdate extends BitcoinCoreContainerEvent {
  final ContainerStatusMessage status;

  _BitcoinCoreStatusUpdate(this.status);
}
