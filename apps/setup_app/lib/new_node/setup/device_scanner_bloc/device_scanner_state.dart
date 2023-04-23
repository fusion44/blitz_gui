part of 'device_scanner_bloc.dart';

abstract class DeviceScannerState extends Equatable {
  const DeviceScannerState();

  @override
  List<Object> get props => [];
}

class DeviceScannerInitial extends DeviceScannerState {}

class NetworkScanProgressState extends DeviceScannerState {
  final double progress;
  final List<BlitzNetworkDevice> devices;

  const NetworkScanProgressState(this.progress, this.devices);

  NetworkScanProgressState copyWith({
    double? progress,
    List<BlitzNetworkDevice>? devices,
  }) {
    return NetworkScanProgressState(
      progress ?? this.progress,
      devices ?? this.devices,
    );
  }

  @override
  List<Object> get props => [...devices, progress];
}

class NetworkScanFinishedState extends DeviceScannerState {
  final List<BlitzNetworkDevice> devices;

  const NetworkScanFinishedState(this.devices);

  @override
  List<Object> get props => devices;
}

class NetworkScanErrorState extends DeviceScannerState {
  final String message;

  const NetworkScanErrorState(this.message);

  @override
  List<Object> get props => [message];
}
