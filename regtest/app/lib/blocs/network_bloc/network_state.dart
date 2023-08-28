part of 'network_bloc.dart';

final class NetworkState {
  final NetworkStateMessage statusMessage;

  NetworkState(this.statusMessage);

  NetworkState copyWith({
    NetworkStateMessage? statusMessage,
  }) {
    return NetworkState(
      statusMessage ?? this.statusMessage,
    );
  }
}
