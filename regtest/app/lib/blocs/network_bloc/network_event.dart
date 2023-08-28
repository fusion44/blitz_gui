part of 'network_bloc.dart';

@immutable
sealed class NetworkEvent {}

class _SendNetworkUpdate extends NetworkEvent {
  final NetworkStateMessage networkState;

  _SendNetworkUpdate(this.networkState);
}
