part of 'system_info_bloc.dart';

abstract class SystemInfoBaseState extends Equatable {
  const SystemInfoBaseState();

  @override
  List<Object> get props => [];
}

class SystemInfoInitial extends SystemInfoBaseState {}

class SystemInfoState extends SystemInfoBaseState {
  final SystemInfo info;

  const SystemInfoState(this.info);

  @override
  List<Object> get props => [info];
}
