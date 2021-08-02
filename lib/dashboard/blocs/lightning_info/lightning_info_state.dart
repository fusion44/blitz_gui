part of 'lightning_info_bloc.dart';

abstract class LightningInfoBaseState extends Equatable {
  const LightningInfoBaseState();

  @override
  List<Object> get props => [];
}

class LightningInfoInitial extends LightningInfoBaseState {}

class LightningInfoState extends LightningInfoBaseState {
  final LightningInfo info;

  LightningInfoState(this.info);
  @override
  List<Object> get props => [info];
}
