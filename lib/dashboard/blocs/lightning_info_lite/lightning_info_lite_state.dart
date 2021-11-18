part of 'lightning_info_lite_bloc.dart';

abstract class LightningInfoLiteBaseState extends Equatable {
  const LightningInfoLiteBaseState();

  @override
  List<Object?> get props => [];
}

class LightningInfoLiteInitial extends LightningInfoLiteBaseState {}

class LightningInfoLiteState extends LightningInfoLiteBaseState {
  final LightningInfoLite? info;

  const LightningInfoLiteState({this.info});

  LightningInfoLiteState copyWith({
    LightningInfoLite? lnInfo,
    WalletBalance? walletBalance,
  }) {
    return LightningInfoLiteState(info: lnInfo ?? info);
  }

  @override
  List<Object?> get props => [
        info!.version,
        info!.numPendingChannels,
        info!.numActiveChannels,
        info!.numInactiveChannels,
        info!.numPeers,
        info!.blockHeight,
        info!.syncedToChain,
        info!.syncedToGraph,
      ];
}
