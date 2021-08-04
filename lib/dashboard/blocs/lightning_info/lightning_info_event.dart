part of 'lightning_info_bloc.dart';

abstract class LightningInfoEvent extends Equatable {
  const LightningInfoEvent();

  @override
  List<Object> get props => [];
}

class StartListenLightningInfo extends LightningInfoEvent {}

class StopListenLightningInfo extends LightningInfoEvent {}

class _LightningInfoUpdate extends LightningInfoEvent {
  final WalletBalance? walletBalance;
  final LightningInfo? lnInfo;

  _LightningInfoUpdate({this.lnInfo, this.walletBalance});
}
