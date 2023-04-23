import 'package:blitz_api_client/blitz_api_client.dart';
import 'package:test/test.dart';

// tests for NetworkInfo
void main() {
  final instance = NetworkInfoBuilder();
  // TODO add properties to the builder and call build()

  group(NetworkInfo, () {
    // The bitcoin core server version
    // int version
    test('to test the property `version`', () async {
      // TODO
    });

    // The server subversion string
    // String subversion
    test('to test the property `subversion`', () async {
      // TODO
    });

    // The protocol version
    // int protocolVersion
    test('to test the property `protocolVersion`', () async {
      // TODO
    });

    // The services we offer to the network, hex formatted
    // String localServices
    test('to test the property `localServices`', () async {
      // TODO
    });

    // The services we offer to the network, in human-readable form
    // BuiltList<String> localServicesNames (default value: ListBuilder())
    test('to test the property `localServicesNames`', () async {
      // TODO
    });

    // True if transaction relay is requested from peers
    // bool localRelay
    test('to test the property `localRelay`', () async {
      // TODO
    });

    // The time offset
    // int timeOffset
    test('to test the property `timeOffset`', () async {
      // TODO
    });

    // The total number of connections
    // int connections
    test('to test the property `connections`', () async {
      // TODO
    });

    // The number of inbound connections
    // int connectionsIn
    test('to test the property `connectionsIn`', () async {
      // TODO
    });

    // The number of outbound connections
    // int connectionsOut
    test('to test the property `connectionsOut`', () async {
      // TODO
    });

    // Whether p2p networking is enabled
    // bool networkActive
    test('to test the property `networkActive`', () async {
      // TODO
    });

    // Information per network
    // BuiltList<BtcNetwork> networks
    test('to test the property `networks`', () async {
      // TODO
    });

    // Minimum relay fee for transactions in BTC/kB
    // int relayFee
    test('to test the property `relayFee`', () async {
      // TODO
    });

    // Minimum fee increment for mempool limiting or BIP 125 replacement in BTC/kB
    // int incrementalFee
    test('to test the property `incrementalFee`', () async {
      // TODO
    });

    // List of local addresses
    // BuiltList<BtcLocalAddress> localAddresses (default value: ListBuilder())
    test('to test the property `localAddresses`', () async {
      // TODO
    });

    // Any network and blockchain warnings
    // String warnings
    test('to test the property `warnings`', () async {
      // TODO
    });
  });
}
