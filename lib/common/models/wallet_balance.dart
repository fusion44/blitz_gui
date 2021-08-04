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
      localBalance: json['local_balance'] != null
          ? Amount.fromJson(json['local_balance'])
          : Amount(),
      remoteBalance: json['remote_balance'] != null
          ? Amount.fromJson(json['remote_balance'])
          : Amount(),
      unsettledLocalBalance: json['unsettled_local_balance'] != null
          ? Amount.fromJson(json['unsettled_local_balance'])
          : Amount(),
      unsettledRemoteBalance: json['unsettled_remote_balance'] != null
          ? Amount.fromJson(json['unsettled_remote_balance'])
          : Amount(),
      pendingOpenLocalBalance: json['pending_open_local_balance'] != null
          ? Amount.fromJson(json['pending_open_local_balance'])
          : Amount(),
      pendingOpenRemoteBalance: json['pending_open_remote_balance'] != null
          ? Amount.fromJson(json['pending_open_remote_balance'])
          : Amount(),
    );
  }
}
