part of 'device_scanner_bloc.dart';

@immutable
class DeviceScannerEvent extends Equatable {
  @override
  List<Object> get props => [];
}

@immutable
class DeviceScanStart extends DeviceScannerEvent {
  @override
  List<Object> get props => [];
}

@immutable
class DeviceScanStop extends DeviceScannerEvent {
  @override
  List<Object> get props => [];
}

@immutable
class _DeviceScanError extends DeviceScannerEvent {
  final String message;

  _DeviceScanError(this.message);

  @override
  List<Object> get props => [];
}

@immutable
class _DeviceScanProgressUpdate extends DeviceScannerEvent {
  final NetworkScanProgressState state;

  _DeviceScanProgressUpdate(this.state);

  @override
  List<Object> get props => [state.progress, ...state.devices];
}

@immutable
class _DeviceScanFinished extends DeviceScannerEvent {
  final List<BlitzNetworkDevice> devices;

  _DeviceScanFinished(this.devices);

  @override
  List<Object> get props => [...devices];
}
