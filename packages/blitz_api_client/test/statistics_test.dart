import 'package:blitz_api_client/blitz_api_client.dart';
import 'package:test/test.dart';

// tests for Statistics
void main() {
  final instance = StatisticsBuilder();
  // TODO add properties to the builder and call build()

  group(Statistics, () {
    // The length in blocks of the BIP9 signalling period
    // int period
    test('to test the property `period`', () async {
      // TODO
    });

    // The number of blocks with the version bit set required to activate the feature
    // int threshold
    test('to test the property `threshold`', () async {
      // TODO
    });

    // The number of blocks elapsed since the beginning of the current period
    // int elapsed
    test('to test the property `elapsed`', () async {
      // TODO
    });

    // The number of blocks with the version bit set in the current period
    // int count
    test('to test the property `count`', () async {
      // TODO
    });

    // False if there are not enough blocks left in this period to pass activation threshold
    // bool possible
    test('to test the property `possible`', () async {
      // TODO
    });
  });
}
