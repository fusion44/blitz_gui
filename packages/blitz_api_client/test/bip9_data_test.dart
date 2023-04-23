import 'package:blitz_api_client/blitz_api_client.dart';
import 'package:test/test.dart';

// tests for Bip9Data
void main() {
  final instance = Bip9DataBuilder();
  // TODO add properties to the builder and call build()

  group(Bip9Data, () {
    // One of \"defined\", \"started\", \"locked_in\", \"active\", \"failed\"
    // String status
    test('to test the property `status`', () async {
      // TODO
    });

    // the bit(0-28) in the block version field used to signal this softfork(only for `started` status)
    // int bit
    test('to test the property `bit`', () async {
      // TODO
    });

    // The minimum median time past of a block at which the bit gains its meaning
    // int startTime
    test('to test the property `startTime`', () async {
      // TODO
    });

    // The median time past of a block at which the deployment is considered failed if not yet locked in
    // int timeout
    test('to test the property `timeout`', () async {
      // TODO
    });

    // Height of the first block to which the status applies
    // int since
    test('to test the property `since`', () async {
      // TODO
    });

    // Minimum height of blocks for which the rules may be enforced
    // int minActivationHeight
    test('to test the property `minActivationHeight`', () async {
      // TODO
    });

    // Statistics statistics
    test('to test the property `statistics`', () async {
      // TODO
    });

    // Height of the first block which the rules are or will be enforced(only for `buried` type, or `bip9` type with `active` status)
    // int height
    test('to test the property `height`', () async {
      // TODO
    });

    // True if the rules are enforced for the mempool and the next block
    // bool active
    test('to test the property `active`', () async {
      // TODO
    });
  });
}
