import 'package:blitz_api_client/blitz_api_client.dart';
import 'package:test/test.dart';

// tests for RawTransaction
void main() {
  final instance = RawTransactionBuilder();
  // TODO add properties to the builder and call build()

  group(RawTransaction, () {
    // Whether specified block is in the active chain or not (only present with explicit \"blockhash\" argument)
    // bool inActiveChain
    test('to test the property `inActiveChain`', () async {
      // TODO
    });

    // The transaction id (same as provided)
    // String txid
    test('to test the property `txid`', () async {
      // TODO
    });

    // The transaction hash (differs from txid for witness transactions)
    // String hash
    test('to test the property `hash`', () async {
      // TODO
    });

    // The serialized transaction size
    // int size
    test('to test the property `size`', () async {
      // TODO
    });

    // The virtual transaction size (differs from size for witness transactions)
    // int vsize
    test('to test the property `vsize`', () async {
      // TODO
    });

    // The transaction's weight (between vsize*4 - 3 and vsize*4)
    // int weight
    test('to test the property `weight`', () async {
      // TODO
    });

    // The version
    // int version
    test('to test the property `version`', () async {
      // TODO
    });

    // The lock time
    // int locktime
    test('to test the property `locktime`', () async {
      // TODO
    });

    // The transaction's inputs
    // BuiltList<JsonObject> vin
    test('to test the property `vin`', () async {
      // TODO
    });

    // The transaction's outputs
    // BuiltList<JsonObject> vout
    test('to test the property `vout`', () async {
      // TODO
    });

    // The block hash
    // String blockhash
    test('to test the property `blockhash`', () async {
      // TODO
    });

    // The number of confirmations
    // int confirmations
    test('to test the property `confirmations`', () async {
      // TODO
    });

    // The block time in seconds since epoch (Jan 1 1970 GMT)
    // int blocktime
    test('to test the property `blocktime`', () async {
      // TODO
    });
  });
}
