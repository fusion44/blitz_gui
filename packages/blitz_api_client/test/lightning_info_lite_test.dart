import 'package:blitz_api_client/blitz_api_client.dart';
import 'package:test/test.dart';

// tests for LightningInfoLite
void main() {
  final instance = LightningInfoLiteBuilder();
  // TODO add properties to the builder and call build()

  group(LightningInfoLite, () {
    // Lightning software implementation (LND, c-lightning)
    // String implementation
    test('to test the property `implementation`', () async {
      // TODO
    });

    // Version of the implementation
    // String version
    test('to test the property `version`', () async {
      // TODO
    });

    // The identity pubkey of the current node
    // String identityPubkey
    test('to test the property `identityPubkey`', () async {
      // TODO
    });

    // The complete URI of the current node
    // String identityUri
    test('to test the property `identityUri`', () async {
      // TODO
    });

    // Number of pending channels
    // int numPendingChannels
    test('to test the property `numPendingChannels`', () async {
      // TODO
    });

    // Number of active channels
    // int numActiveChannels
    test('to test the property `numActiveChannels`', () async {
      // TODO
    });

    // Number of inactive channels
    // int numInactiveChannels
    test('to test the property `numInactiveChannels`', () async {
      // TODO
    });

    // Number of peers
    // int numPeers
    test('to test the property `numPeers`', () async {
      // TODO
    });

    // The node's current view of the height of the best block
    // int blockHeight
    test('to test the property `blockHeight`', () async {
      // TODO
    });

    // Whether the wallet's view is synced to the main chain
    // bool syncedToChain
    test('to test the property `syncedToChain`', () async {
      // TODO
    });

    // Whether we consider ourselves synced with the public channel graph.
    // bool syncedToGraph
    test('to test the property `syncedToGraph`', () async {
      // TODO
    });
  });
}
