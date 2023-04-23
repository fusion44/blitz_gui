import 'package:blitz_api_client/blitz_api_client.dart';
import 'package:test/test.dart';

// tests for PaymentRequest
void main() {
  final instance = PaymentRequestBuilder();
  // TODO add properties to the builder and call build()

  group(PaymentRequest, () {
    // String destination
    test('to test the property `destination`', () async {
      // TODO
    });

    // String paymentHash
    test('to test the property `paymentHash`', () async {
      // TODO
    });

    // Deprecated. User num_msat instead
    // int numSatoshis
    test('to test the property `numSatoshis`', () async {
      // TODO
    });

    // int timestamp
    test('to test the property `timestamp`', () async {
      // TODO
    });

    // int expiry
    test('to test the property `expiry`', () async {
      // TODO
    });

    // String description
    test('to test the property `description`', () async {
      // TODO
    });

    // String descriptionHash
    test('to test the property `descriptionHash`', () async {
      // TODO
    });

    // String fallbackAddr
    test('to test the property `fallbackAddr`', () async {
      // TODO
    });

    // int cltvExpiry
    test('to test the property `cltvExpiry`', () async {
      // TODO
    });

    // A list of [HopHint] for the RouteHint
    // BuiltList<RouteHint> routeHints (default value: ListBuilder())
    test('to test the property `routeHints`', () async {
      // TODO
    });

    // The payment address in hex format
    // String paymentAddr (default value: '')
    test('to test the property `paymentAddr`', () async {
      // TODO
    });

    // int numMsat
    test('to test the property `numMsat`', () async {
      // TODO
    });

    // BuiltList<FeaturesEntry> features (default value: ListBuilder())
    test('to test the property `features`', () async {
      // TODO
    });

    // Optional requested currency of the payment.
    // String currency (default value: '')
    test('to test the property `currency`', () async {
      // TODO
    });
  });
}
