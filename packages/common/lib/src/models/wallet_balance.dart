import 'amount.dart';

class WalletBalance {
  final int onchainConfirmedBalance;
  final int onchainTotalBalance;
  final int onchainUnconfirmedBalance;
  final Amount localBalance;
  final Amount remoteBalance;
  final Amount unsettledLocalBalance;
  final Amount unsettledRemoteBalance;
  final Amount pendingOpenLocalBalance;
  final Amount pendingOpenRemoteBalance;

  const WalletBalance({
    this.onchainConfirmedBalance = 0,
    this.onchainTotalBalance = 0,
    this.onchainUnconfirmedBalance = 0,
    this.localBalance = const Amount(),
    this.remoteBalance = const Amount(),
    this.unsettledLocalBalance = const Amount(),
    this.unsettledRemoteBalance = const Amount(),
    this.pendingOpenLocalBalance = const Amount(),
    this.pendingOpenRemoteBalance = const Amount(),
  });

  static WalletBalance fromJson(Map<String, dynamic> json) {
    return WalletBalance(
      onchainConfirmedBalance: json['onchain_confirmed_balance'],
      onchainTotalBalance: json['onchain_total_balance'],
      onchainUnconfirmedBalance: json['onchain_unconfirmed_balance'],
      localBalance: json['channel_local_balance'] != null
          ? Amount.fromMSats(json['channel_local_balance'])
          : const Amount(),
      remoteBalance: json['channel_remote_balance'] != null
          ? Amount.fromMSats(json['channel_remote_balance'])
          : const Amount(),
      unsettledLocalBalance: json['channel_unsettled_local_balance'] != null
          ? Amount.fromMSats(json['channel_unsettled_local_balance'])
          : const Amount(),
      unsettledRemoteBalance: json['channel_unsettled_remote_balance'] != null
          ? Amount.fromMSats(json['channel_unsettled_remote_balance'])
          : const Amount(),
      pendingOpenLocalBalance:
          json['channel_pending_open_local_balance'] != null
              ? Amount.fromMSats(json['channel_pending_open_local_balance'])
              : const Amount(),
      pendingOpenRemoteBalance:
          json['channel_pending_open_remote_balance'] != null
              ? Amount.fromMSats(json['channel_pending_open_remote_balance'])
              : const Amount(),
    );
  }
}
