import 'package:blitz_api_client/blitz_api_client.dart';
import 'package:test/test.dart';

// tests for SendCoinsInput
void main() {
  final instance = SendCoinsInputBuilder();
  // TODO add properties to the builder and call build()

  group(SendCoinsInput, () {
    // The base58 or bech32 encoded bitcoin address to send coins to on-chain
    // String address
    test('to test the property `address`', () async {
      // TODO
    });

    // The number of blocks that the transaction *should* confirm in, will be used for fee estimation
    // int targetConf
    test('to test the property `targetConf`', () async {
      // TODO
    });

    // A manual fee expressed in sat/vbyte that should be used when crafting the transaction (default: 0)
    // int satPerVbyte
    test('to test the property `satPerVbyte`', () async {
      // TODO
    });

    // The minimum number of confirmations each one of your outputs used for the transaction must satisfy
    // int minConfs (default value: 1)
    test('to test the property `minConfs`', () async {
      // TODO
    });

    // A label for the transaction. Ignored by CLN backend.
    // String label (default value: '')
    test('to test the property `label`', () async {
      // TODO
    });

    // Send all available on-chain funds from the wallet. Will be executed `amount` is **0**
    // bool sendAll (default value: false)
    test('to test the property `sendAll`', () async {
      // TODO
    });

    // The number of bitcoin denominated in satoshis to send. Must not be set when `send_all` is true.
    // int amount (default value: 0)
    test('to test the property `amount`', () async {
      // TODO
    });
  });
}
