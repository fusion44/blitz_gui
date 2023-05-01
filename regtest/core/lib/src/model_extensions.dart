import 'package:blitz_api_client/blitz_api_client.dart';

extension WalletBalanceExtensions on WalletBalance {
  int get total =>
      onchainTotalBalance +
      channelLocalBalance +
      channelRemoteBalance +
      channelUnsettledLocalBalance +
      channelUnsettledRemoteBalance +
      channelPendingOpenLocalBalance +
      channelPendingOpenRemoteBalance;

  int get totalChannelBalance =>
      channelLocalBalance +
      channelRemoteBalance +
      channelUnsettledLocalBalance +
      channelUnsettledRemoteBalance +
      channelPendingOpenLocalBalance +
      channelPendingOpenRemoteBalance;

  int get confirmed =>
      onchainConfirmedBalance + channelLocalBalance + channelRemoteBalance;

  // returns true if the wallet has no funds anywhere
  bool get isEmpty => total == 0;

  // returns true if the wallet has funds somewhere
  bool get isNotEmpty => total != 0;
  bool get hasOnchainFunds => onchainTotalBalance > 0;
  bool get hasNoOnchainFunds => onchainTotalBalance == 0;
  bool get hasChannelFunds => totalChannelBalance > 0;
  bool get hasNoChannelFunds => totalChannelBalance == 0;
  bool get hasUnconfirmedFunds => onchainUnconfirmedBalance > 0;

  // returns true if balances are higher than the other balance object
  bool isHigherThan(WalletBalance other, {bool confirmedOnly = false}) {
    if (confirmedOnly) {
      return confirmed > other.confirmed;
    }
    return total > other.total;
  }
}
