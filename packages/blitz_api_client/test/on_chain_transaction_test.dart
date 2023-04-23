import 'package:blitz_api_client/blitz_api_client.dart';
import 'package:test/test.dart';

// tests for OnChainTransaction
void main() {
  final instance = OnChainTransactionBuilder();
  // TODO add properties to the builder and call build()

  group(OnChainTransaction, () {
    // The transaction hash
    // String txHash
    test('to test the property `txHash`', () async {
      // TODO
    });

    // The transaction amount, denominated in satoshis
    // int amount
    test('to test the property `amount`', () async {
      // TODO
    });

    // The number of confirmations
    // int numConfirmations
    test('to test the property `numConfirmations`', () async {
      // TODO
    });

    // The height of the block this transaction was included in
    // int blockHeight
    test('to test the property `blockHeight`', () async {
      // TODO
    });

    // Timestamp of this transaction
    // int timeStamp
    test('to test the property `timeStamp`', () async {
      // TODO
    });

    // Fees paid for this transaction
    // int totalFees
    test('to test the property `totalFees`', () async {
      // TODO
    });

    // Addresses that received funds for this transaction
    // BuiltList<String> destAddresses (default value: ListBuilder())
    test('to test the property `destAddresses`', () async {
      // TODO
    });

    // An optional label that was set on transaction broadcast.
    // String label (default value: '')
    test('to test the property `label`', () async {
      // TODO
    });
  });
}
