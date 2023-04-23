import 'package:blitz_api_client/blitz_api_client.dart';
import 'package:test/test.dart';

// tests for BtcInfo
void main() {
  final instance = BtcInfoBuilder();
  // TODO add properties to the builder and call build()

  group(BtcInfo, () {
    // The height of the most-work fully-validated chain. The genesis block has height 0
    // int blocks
    test('to test the property `blocks`', () async {
      // TODO
    });

    // The current number of headers we have validated
    // int headers
    test('to test the property `headers`', () async {
      // TODO
    });

    // Estimate of verification progress[0..1]
    // num verificationProgress
    test('to test the property `verificationProgress`', () async {
      // TODO
    });

    // The current difficulty
    // int difficulty
    test('to test the property `difficulty`', () async {
      // TODO
    });

    // The estimated size of the block and undo files on disk
    // int sizeOnDisk
    test('to test the property `sizeOnDisk`', () async {
      // TODO
    });

    // Which networks are in use (ipv4, ipv6 or onion)
    // BuiltList<BtcNetwork> networks (default value: ListBuilder())
    test('to test the property `networks`', () async {
      // TODO
    });

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
  });
}
