part of 'system_info_bloc.dart';

abstract class SystemInfoEvent extends Equatable {
  const SystemInfoEvent();

  @override
  List<Object> get props => [];
}

class StartListenSystemInfo extends SystemInfoEvent {}

class StopListenSystemInfo extends SystemInfoEvent {}

class _SystemInfoUpdate extends SystemInfoEvent {
  final SystemInfo info;

  const _SystemInfoUpdate(this.info);
}
