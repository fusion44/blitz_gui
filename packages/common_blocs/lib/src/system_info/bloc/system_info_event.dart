part of 'system_info_bloc.dart';

abstract class SystemInfoBaseEvent extends Equatable {
  const SystemInfoBaseEvent();

  @override
  List<Object> get props => [];
}

class StartListenSystemInfo extends SystemInfoBaseEvent {}

class StopListenSystemInfo extends SystemInfoBaseEvent {}

class _SystemInfoUpdate extends SystemInfoBaseEvent {
  final SystemInfo info;

  const _SystemInfoUpdate(this.info);

  @override
  List<Object> get props => [info];
}
