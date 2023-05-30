part of 'bitcoin_core_container_bloc.dart';

@immutable
abstract class BitcoinCoreContainerState {}

class BitcoinCoreContainerInitial extends BitcoinCoreContainerState {}

class BitcoinCoreStatusUpdate extends BitcoinCoreContainerState {
  final ContainerStatusMessage status;

  BitcoinCoreStatusUpdate(this.status);
}
