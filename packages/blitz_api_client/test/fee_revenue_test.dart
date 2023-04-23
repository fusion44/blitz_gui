import 'package:blitz_api_client/blitz_api_client.dart';
import 'package:test/test.dart';

// tests for FeeRevenue
void main() {
  final instance = FeeRevenueBuilder();
  // TODO add properties to the builder and call build()

  group(FeeRevenue, () {
    // Fee revenue earned in the last 24 hours
    // int day
    test('to test the property `day`', () async {
      // TODO
    });

    // Fee revenue earned in the last 7days
    // int week
    test('to test the property `week`', () async {
      // TODO
    });

    // Fee revenue earned in the last month
    // int month
    test('to test the property `month`', () async {
      // TODO
    });

    // Fee revenue earned in the last year. Might be null if not implemented by backend.
    // int year
    test('to test the property `year`', () async {
      // TODO
    });

    // Fee revenue earned in the last year. Might be null if not implemented by backend
    // int total
    test('to test the property `total`', () async {
      // TODO
    });
  });
}
