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
  final FeeRevenueData? feeRevenueData;

  const LightningInfoState({
    this.info,
    this.walletBalance,
    this.feeRevenueData,
  });

  LightningInfoState copyWith({
    LightningInfo? lnInfo,
    WalletBalance? walletBalance,
    FeeRevenueData? feeRevenueData,
  }) {
    return LightningInfoState(
      info: lnInfo ?? info,
      walletBalance: walletBalance ?? this.walletBalance,
      feeRevenueData: feeRevenueData ?? this.feeRevenueData,
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
        walletBalance?.onchainConfirmedBalance,
        walletBalance?.onchainTotalBalance,
        walletBalance?.onchainUnconfirmedBalance,
        walletBalance?.localBalance.msat,
        walletBalance?.remoteBalance.msat,
        walletBalance?.unsettledLocalBalance.msat,
        walletBalance?.unsettledRemoteBalance.msat,
        walletBalance?.pendingOpenLocalBalance.msat,
        walletBalance?.pendingOpenRemoteBalance.msat,
        feeRevenueData?.day,
        feeRevenueData?.month,
        feeRevenueData?.week,
        feeRevenueData?.year,
        feeRevenueData?.total,
      ];
}
