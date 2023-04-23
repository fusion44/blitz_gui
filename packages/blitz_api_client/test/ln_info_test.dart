import 'package:blitz_api_client/blitz_api_client.dart';
import 'package:test/test.dart';

// tests for LnInfo
void main() {
  final instance = LnInfoBuilder();
  // TODO add properties to the builder and call build()

  group(LnInfo, () {
    // Lightning software implementation (LND, CLN)
    // String implementation
    test('to test the property `implementation`', () async {
      // TODO
    });

    // The version of the software that the node is running.
    // String version
    test('to test the property `version`', () async {
      // TODO
    });

    // The SHA1 commit hash that the daemon is compiled with.
    // String commitHash
    test('to test the property `commitHash`', () async {
      // TODO
    });

    // String identityPubkey (default value: 'The identity pubkey of the current node.')
    test('to test the property `identityPubkey`', () async {
      // TODO
    });

    // String identityUri (default value: 'The complete URI (pubkey@physicaladdress:port) the current node.')
    test('to test the property `identityUri`', () async {
      // TODO
    });

    // The alias of the node.
    // String alias
    test('to test the property `alias`', () async {
      // TODO
    });

    // The color of the current node in hex code format.
    // String color
    test('to test the property `color`', () async {
      // TODO
    });

    // Number of pending channels.
    // int numPendingChannels
    test('to test the property `numPendingChannels`', () async {
      // TODO
    });

    // Number of active channels.
    // int numActiveChannels
    test('to test the property `numActiveChannels`', () async {
      // TODO
    });

    // Number of inactive channels.
    // int numInactiveChannels
    test('to test the property `numInactiveChannels`', () async {
      // TODO
    });

    // Number of peers.
    // int numPeers
    test('to test the property `numPeers`', () async {
      // TODO
    });

    // The node's current view of the height of the best block. Only available with LND.
    // int blockHeight
    test('to test the property `blockHeight`', () async {
      // TODO
    });

    // The node's current view of the hash of the best block. Only available with LND.
    // String blockHash (default value: '')
    test('to test the property `blockHash`', () async {
      // TODO
    });

    // Timestamp of the block best known to the wallet. Only available with LND.
    // int bestHeaderTimestamp
    test('to test the property `bestHeaderTimestamp`', () async {
      // TODO
    });

    // Whether the wallet's view is synced to the main chain. Only available with LND.
    // bool syncedToChain
    test('to test the property `syncedToChain`', () async {
      // TODO
    });

    // Whether we consider ourselves synced with the public channel graph. Only available with LND.
    // bool syncedToGraph
    test('to test the property `syncedToGraph`', () async {
      // TODO
    });

    // A list of active chains the node is connected to
    // BuiltList<Chain> chains (default value: ListBuilder())
    test('to test the property `chains`', () async {
      // TODO
    });

    // The URIs of the current node.
    // BuiltList<String> uris (default value: ListBuilder())
    test('to test the property `uris`', () async {
      // TODO
    });

    // Features that our node has advertised in our init message node announcements and invoices. Not yet implemented with CLN
    // BuiltList<FeaturesEntry> features (default value: ListBuilder())
    test('to test the property `features`', () async {
      // TODO
    });
  });
}
