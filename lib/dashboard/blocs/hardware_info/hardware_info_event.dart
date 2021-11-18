part of 'hardware_info_bloc.dart';

abstract class HardwareInfoEvent extends Equatable {
  const HardwareInfoEvent();

  @override
  List<Object> get props => [];
}

class StartListenHardwareInfo extends HardwareInfoEvent {}

class StopListenHardwareInfo extends HardwareInfoEvent {}

class _HardwareInfoErrorEvent extends HardwareInfoEvent {
  final String message;

  const _HardwareInfoErrorEvent(this.message);
}

class _HardwareInfoUpdate extends HardwareInfoEvent {
  final HardwareInfo info;

  const _HardwareInfoUpdate(this.info);
}
