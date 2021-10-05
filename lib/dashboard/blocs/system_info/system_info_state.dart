part of 'system_info_bloc.dart';

abstract class SystemInfoBaseState extends Equatable {
  const SystemInfoBaseState();

  @override
  List<Object> get props => [];
}

class SystemInfoInitial extends SystemInfoBaseState {}

class SystemInfoState extends SystemInfoBaseState {
  final SystemInfo info;
  // in Kb/s
  final double uploadRate;
  // in Kb/s
  final double downloadRate;

  const SystemInfoState(this.info, this.uploadRate, this.downloadRate);

  @override
  List<Object> get props => [info, uploadRate, downloadRate];
}
