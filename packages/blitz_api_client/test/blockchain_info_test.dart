import 'package:blitz_api_client/blitz_api_client.dart';
import 'package:test/test.dart';

// tests for BlockchainInfo
void main() {
  final instance = BlockchainInfoBuilder();
  // TODO add properties to the builder and call build()

  group(BlockchainInfo, () {
    // Current network name(main, test, regtest)
    // String chain
    test('to test the property `chain`', () async {
      // TODO
    });

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

    // The hash of the currently best block
    // String bestBlockHash
    test('to test the property `bestBlockHash`', () async {
      // TODO
    });

    // The current difficulty
    // int difficulty
    test('to test the property `difficulty`', () async {
      // TODO
    });

    // Median time for the current best block
    // int mediantime
    test('to test the property `mediantime`', () async {
      // TODO
    });

    // Estimate of verification progress[0..1]
    // num verificationProgress
    test('to test the property `verificationProgress`', () async {
      // TODO
    });

    // Estimate of whether this node is in Initial Block Download mode
    // bool initialBlockDownload
    test('to test the property `initialBlockDownload`', () async {
      // TODO
    });

    // total amount of work in active chain, in hexadecimal
    // String chainwork
    test('to test the property `chainwork`', () async {
      // TODO
    });

    // The estimated size of the block and undo files on disk
    // int sizeOnDisk
    test('to test the property `sizeOnDisk`', () async {
      // TODO
    });

    // If the blocks are subject to pruning
    // bool pruned
    test('to test the property `pruned`', () async {
      // TODO
    });

    // Lowest-height complete block stored(only present if pruning is enabled)
    // int pruneHeight
    test('to test the property `pruneHeight`', () async {
      // TODO
    });

    // Whether automatic pruning is enabled(only present if pruning is enabled)
    // bool automaticPruning
    test('to test the property `automaticPruning`', () async {
      // TODO
    });

    // The target size used by pruning(only present if automatic pruning is enabled)
    // int pruneTargetSize
    test('to test the property `pruneTargetSize`', () async {
      // TODO
    });

    // Any network and blockchain warnings
    // String warnings
    test('to test the property `warnings`', () async {
      // TODO
    });

    // Status of softforks
    // BuiltList<SoftFork> softforks
    test('to test the property `softforks`', () async {
      // TODO
    });
  });
}
