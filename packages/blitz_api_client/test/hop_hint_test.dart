import 'package:blitz_api_client/blitz_api_client.dart';
import 'package:test/test.dart';

// tests for HopHint
void main() {
  final instance = HopHintBuilder();
  // TODO add properties to the builder and call build()

  group(HopHint, () {
    // The public key of the node at the start of the channel.
    // String nodeId
    test('to test the property `nodeId`', () async {
      // TODO
    });

    // The unique identifier of the channel.
    // String chanId
    test('to test the property `chanId`', () async {
      // TODO
    });

    // The base fee of the channel denominated in msat.
    // int feeBaseMsat
    test('to test the property `feeBaseMsat`', () async {
      // TODO
    });

    // The fee rate of the channel for sending one satoshi across it denominated in msat
    // int feeProportionalMillionths
    test('to test the property `feeProportionalMillionths`', () async {
      // TODO
    });

    // The time-lock delta of the channel.
    // int cltvExpiryDelta
    test('to test the property `cltvExpiryDelta`', () async {
      // TODO
    });
  });
}
