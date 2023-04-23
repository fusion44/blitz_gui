import 'package:blitz_api_client/blitz_api_client.dart';
import 'package:test/test.dart';

// tests for SoftFork
void main() {
  final instance = SoftForkBuilder();
  // TODO add properties to the builder and call build()

  group(SoftFork, () {
    // Name of the softfork
    // String name
    test('to test the property `name`', () async {
      // TODO
    });

    // One of \"buried\", \"bip9\"
    // String type
    test('to test the property `type`', () async {
      // TODO
    });

    // True **if** the rules are enforced for the mempool and the next block
    // bool active
    test('to test the property `active`', () async {
      // TODO
    });

    // Bip9 bip9
    test('to test the property `bip9`', () async {
      // TODO
    });

    // Height of the first block which the rules are or will be enforced (only for `buried` type, or `bip9` type with `active` status)
    // int height
    test('to test the property `height`', () async {
      // TODO
    });
  });
}
