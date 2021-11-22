part of 'hardware_info_bloc.dart';

abstract class HardwareInfoBaseState extends Equatable {
  const HardwareInfoBaseState();

  @override
  List<Object> get props => [];
}

class HardwareInfoInitial extends HardwareInfoBaseState {}

class HardwareInfoState extends HardwareInfoBaseState {
  final HardwareInfo info;
  // in Kb/s
  final double uploadRate;
  // in Kb/s
  final double downloadRate;

  const HardwareInfoState(this.info, this.uploadRate, this.downloadRate);

  @override
  List<Object> get props => [info, uploadRate, downloadRate];
}

class HardwareInfoErrorState extends HardwareInfoBaseState {
  final String message;

  const HardwareInfoErrorState(this.message);
}
