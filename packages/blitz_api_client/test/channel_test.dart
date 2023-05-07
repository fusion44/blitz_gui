import 'package:blitz_api_client/blitz_api_client.dart';
import 'package:test/test.dart';

// tests for Channel
void main() {
  final instance = ChannelBuilder();
  // TODO add properties to the builder and call build()

  group(Channel, () {
    // The unique identifier of the channel
    // String channelId (default value: '')
    test('to test the property `channelId`', () async {
      // TODO
    });

    // The state of the channel
    // ChannelState state
    test('to test the property `state`', () async {
      // TODO
    });

    // Whether the channel is active or not. True if the channel is not closing and the peer is online.
    // bool active
    test('to test the property `active`', () async {
      // TODO
    });

    // The public key of the peer
    // String peerPublickey
    test('to test the property `peerPublickey`', () async {
      // TODO
    });

    // The alias of the peer if available
    // String peerAlias (default value: '')
    test('to test the property `peerAlias`', () async {
      // TODO
    });

    // This node's current balance in this channel
    // int balanceLocal (default value: 0)
    test('to test the property `balanceLocal`', () async {
      // TODO
    });

    // The counterparty's current balance in this channel
    // int balanceRemote (default value: 0)
    test('to test the property `balanceRemote`', () async {
      // TODO
    });

    // The total capacity of the channel
    // int balanceCapacity (default value: 0)
    test('to test the property `balanceCapacity`', () async {
      // TODO
    });

    // Whether the channel was dual funded or not
    // bool dualFunded
    test('to test the property `dualFunded`', () async {
      // TODO
    });

    // Whether the channel was initiated by us, our peer or both
    // ChannelInitiator initiator
    test('to test the property `initiator`', () async {
      // TODO
    });

    // If state is closing, this shows who initiated the close. None, if not in a closing state.
    // ChannelInitiator closer
    test('to test the property `closer`', () async {
      // TODO
    });
  });
}
