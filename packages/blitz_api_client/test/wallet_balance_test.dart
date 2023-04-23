import 'package:blitz_api_client/blitz_api_client.dart';
import 'package:test/test.dart';

// tests for WalletBalance
void main() {
  final instance = WalletBalanceBuilder();
  // TODO add properties to the builder and call build()

  group(WalletBalance, () {
    // Confirmed onchain balance (more than three confirmations) in sat
    // int onchainConfirmedBalance
    test('to test the property `onchainConfirmedBalance`', () async {
      // TODO
    });

    // Total combined onchain balance in sat
    // int onchainTotalBalance
    test('to test the property `onchainTotalBalance`', () async {
      // TODO
    });

    // Unconfirmed onchain balance (less than three confirmations) in sat
    // int onchainUnconfirmedBalance
    test('to test the property `onchainUnconfirmedBalance`', () async {
      // TODO
    });

    // Sum of channels local balances in msat
    // int channelLocalBalance
    test('to test the property `channelLocalBalance`', () async {
      // TODO
    });

    // Sum of channels remote balances in msat.
    // int channelRemoteBalance
    test('to test the property `channelRemoteBalance`', () async {
      // TODO
    });

    // Sum of channels local unsettled balances in msat.
    // int channelUnsettledLocalBalance
    test('to test the property `channelUnsettledLocalBalance`', () async {
      // TODO
    });

    // Sum of channels remote unsettled balances in msat.
    // int channelUnsettledRemoteBalance
    test('to test the property `channelUnsettledRemoteBalance`', () async {
      // TODO
    });

    // Sum of channels pending local balances in msat.
    // int channelPendingOpenLocalBalance
    test('to test the property `channelPendingOpenLocalBalance`', () async {
      // TODO
    });

    // Sum of channels pending remote balances in msat.
    // int channelPendingOpenRemoteBalance
    test('to test the property `channelPendingOpenRemoteBalance`', () async {
      // TODO
    });
  });
}
