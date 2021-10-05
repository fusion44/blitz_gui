part of 'lightning_info_bloc.dart';

abstract class LightningInfoBaseState extends Equatable {
  const LightningInfoBaseState();

  @override
  List<Object?> get props => [];
}

class LightningInfoInitial extends LightningInfoBaseState {}

class LightningInfoState extends LightningInfoBaseState {
  final LightningInfo? info;
  final WalletBalance? walletBalance;

  const LightningInfoState({this.info, this.walletBalance});

  LightningInfoState copyWith({
    LightningInfo? lnInfo,
    WalletBalance? walletBalance,
  }) {
    return LightningInfoState(
      info: lnInfo ?? info,
      walletBalance: walletBalance ?? this.walletBalance,
    );
  }

  @override
  List<Object?> get props => [
        info!.version,
        info!.commitHash,
        info!.alias,
        info!.color,
        info!.numPendingChannels,
        info!.numActiveChannels,
        info!.numInactiveChannels,
        info!.numPeers,
        info!.blockHeight,
        info!.blockHash,
        info!.bestHeaderTimestamp,
        info!.syncedToChain,
        info!.syncedToGraph,
        ...info!.chains,
        ...info!.uris,
        ...info!.features,
        walletBalance!.onchainConfirmedBalance,
        walletBalance!.onchainTotalBalance,
        walletBalance!.onchainUnconfirmedBalance,
        walletBalance!.localBalance.msat,
        walletBalance!.remoteBalance.msat,
        walletBalance!.unsettledLocalBalance.msat,
        walletBalance!.unsettledRemoteBalance.msat,
        walletBalance!.pendingOpenLocalBalance.msat,
        walletBalance!.pendingOpenRemoteBalance.msat,
      ];
}
