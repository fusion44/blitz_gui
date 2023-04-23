import 'package:blitz_api_client/blitz_api_client.dart';
import 'package:test/test.dart';

// tests for SendCoinsResponse
void main() {
  final instance = SendCoinsResponseBuilder();
  // TODO add properties to the builder and call build()

  group(SendCoinsResponse, () {
    // The transaction ID for this onchain payment
    // String txid
    test('to test the property `txid`', () async {
      // TODO
    });

    // The base58 or bech32 encoded bitcoin address where the onchain funds where sent to
    // String address
    test('to test the property `address`', () async {
      // TODO
    });

    // The number of bitcoin denominated in satoshis which where sent
    // int amount
    test('to test the property `amount`', () async {
      // TODO
    });

    // The number of bitcoin denominated in satoshis which where paid as fees
    // int fees
    test('to test the property `fees`', () async {
      // TODO
    });

    // The label used for the transaction. Ignored by CLN backend.
    // String label (default value: '')
    test('to test the property `label`', () async {
      // TODO
    });
  });
}
