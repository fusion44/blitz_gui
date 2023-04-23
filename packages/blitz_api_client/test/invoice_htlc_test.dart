import 'package:blitz_api_client/blitz_api_client.dart';
import 'package:test/test.dart';

// tests for InvoiceHTLC
void main() {
  final instance = InvoiceHTLCBuilder();
  // TODO add properties to the builder and call build()

  group(InvoiceHTLC, () {
    // The channel ID over which the HTLC was received.
    // int chanId
    test('to test the property `chanId`', () async {
      // TODO
    });

    // The index of the HTLC on the channel.
    // int htlcIndex
    test('to test the property `htlcIndex`', () async {
      // TODO
    });

    // The amount of the HTLC in msat.
    // int amtMsat
    test('to test the property `amtMsat`', () async {
      // TODO
    });

    // The block height at which this HTLC was accepted.
    // int acceptHeight
    test('to test the property `acceptHeight`', () async {
      // TODO
    });

    // The time at which this HTLC was accepted.
    // int acceptTime
    test('to test the property `acceptTime`', () async {
      // TODO
    });

    // The time at which this HTLC was resolved.
    // int resolveTime
    test('to test the property `resolveTime`', () async {
      // TODO
    });

    // The block height at which this HTLC expires.
    // int expiryHeight
    test('to test the property `expiryHeight`', () async {
      // TODO
    });

    // The state of the HTLC.
    // InvoiceHTLCState state
    test('to test the property `state`', () async {
      // TODO
    });

    // Custom tlv records.
    // BuiltList<CustomRecordsEntry> customRecords (default value: ListBuilder())
    test('to test the property `customRecords`', () async {
      // TODO
    });

    // The total amount of the mpp payment in msat.
    // int mppTotalAmtMsat
    test('to test the property `mppTotalAmtMsat`', () async {
      // TODO
    });

    // Amp1 amp
    test('to test the property `amp`', () async {
      // TODO
    });
  });
}
