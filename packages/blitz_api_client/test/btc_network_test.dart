import 'package:blitz_api_client/blitz_api_client.dart';
import 'package:test/test.dart';

// tests for BtcNetwork
void main() {
  final instance = BtcNetworkBuilder();
  // TODO add properties to the builder and call build()

  group(BtcNetwork, () {
    // Which network is in use (ipv4, ipv6 or onion)
    // String name
    test('to test the property `name`', () async {
      // TODO
    });

    // Is the network limited using - onlynet?
    // bool limited
    test('to test the property `limited`', () async {
      // TODO
    });

    // Is the network reachable?
    // bool reachable
    test('to test the property `reachable`', () async {
      // TODO
    });

    // host:port of the proxy that is used for this network, or empty if none
    // String proxy (default value: '')
    test('to test the property `proxy`', () async {
      // TODO
    });

    // Whether randomized credentials are used
    // bool proxyRandomizeCredentials
    test('to test the property `proxyRandomizeCredentials`', () async {
      // TODO
    });
  });
}
