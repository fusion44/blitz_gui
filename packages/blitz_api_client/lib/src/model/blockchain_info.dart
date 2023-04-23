//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:blitz_api_client/src/model/soft_fork.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'blockchain_info.g.dart';

/// BlockchainInfo
///
/// Properties:
/// * [chain] - Current network name(main, test, regtest)
/// * [blocks] - The height of the most-work fully-validated chain. The genesis block has height 0
/// * [headers] - The current number of headers we have validated
/// * [bestBlockHash] - The hash of the currently best block
/// * [difficulty] - The current difficulty
/// * [mediantime] - Median time for the current best block
/// * [verificationProgress] - Estimate of verification progress[0..1]
/// * [initialBlockDownload] - Estimate of whether this node is in Initial Block Download mode
/// * [chainwork] - total amount of work in active chain, in hexadecimal
/// * [sizeOnDisk] - The estimated size of the block and undo files on disk
/// * [pruned] - If the blocks are subject to pruning
/// * [pruneHeight] - Lowest-height complete block stored(only present if pruning is enabled)
/// * [automaticPruning] - Whether automatic pruning is enabled(only present if pruning is enabled)
/// * [pruneTargetSize] - The target size used by pruning(only present if automatic pruning is enabled)
/// * [warnings] - Any network and blockchain warnings
/// * [softforks] - Status of softforks
abstract class BlockchainInfo
    implements Built<BlockchainInfo, BlockchainInfoBuilder> {
  /// Current network name(main, test, regtest)
  @BuiltValueField(wireName: r'chain')
  String get chain;

  /// The height of the most-work fully-validated chain. The genesis block has height 0
  @BuiltValueField(wireName: r'blocks')
  int get blocks;

  /// The current number of headers we have validated
  @BuiltValueField(wireName: r'headers')
  int get headers;

  /// The hash of the currently best block
  @BuiltValueField(wireName: r'best_block_hash')
  String get bestBlockHash;

  /// The current difficulty
  @BuiltValueField(wireName: r'difficulty')
  int get difficulty;

  /// Median time for the current best block
  @BuiltValueField(wireName: r'mediantime')
  int get mediantime;

  /// Estimate of verification progress[0..1]
  @BuiltValueField(wireName: r'verification_progress')
  num get verificationProgress;

  /// Estimate of whether this node is in Initial Block Download mode
  @BuiltValueField(wireName: r'initial_block_download')
  bool get initialBlockDownload;

  /// total amount of work in active chain, in hexadecimal
  @BuiltValueField(wireName: r'chainwork')
  String get chainwork;

  /// The estimated size of the block and undo files on disk
  @BuiltValueField(wireName: r'size_on_disk')
  int get sizeOnDisk;

  /// If the blocks are subject to pruning
  @BuiltValueField(wireName: r'pruned')
  bool get pruned;

  /// Lowest-height complete block stored(only present if pruning is enabled)
  @BuiltValueField(wireName: r'prune_height')
  int? get pruneHeight;

  /// Whether automatic pruning is enabled(only present if pruning is enabled)
  @BuiltValueField(wireName: r'automatic_pruning')
  bool? get automaticPruning;

  /// The target size used by pruning(only present if automatic pruning is enabled)
  @BuiltValueField(wireName: r'prune_target_size')
  int? get pruneTargetSize;

  /// Any network and blockchain warnings
  @BuiltValueField(wireName: r'warnings')
  String get warnings;

  /// Status of softforks
  @BuiltValueField(wireName: r'softforks')
  BuiltList<SoftFork> get softforks;

  BlockchainInfo._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BlockchainInfoBuilder b) => b;

  factory BlockchainInfo([void updates(BlockchainInfoBuilder b)]) =
      _$BlockchainInfo;

  @BuiltValueSerializer(custom: true)
  static Serializer<BlockchainInfo> get serializer =>
      _$BlockchainInfoSerializer();
}

class _$BlockchainInfoSerializer
    implements StructuredSerializer<BlockchainInfo> {
  @override
  final Iterable<Type> types = const [BlockchainInfo, _$BlockchainInfo];

  @override
  final String wireName = r'BlockchainInfo';

  @override
  Iterable<Object?> serialize(Serializers serializers, BlockchainInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    result
      ..add(r'chain')
      ..add(serializers.serialize(object.chain,
          specifiedType: const FullType(String)));
    result
      ..add(r'blocks')
      ..add(serializers.serialize(object.blocks,
          specifiedType: const FullType(int)));
    result
      ..add(r'headers')
      ..add(serializers.serialize(object.headers,
          specifiedType: const FullType(int)));
    result
      ..add(r'best_block_hash')
      ..add(serializers.serialize(object.bestBlockHash,
          specifiedType: const FullType(String)));
    result
      ..add(r'difficulty')
      ..add(serializers.serialize(object.difficulty,
          specifiedType: const FullType(int)));
    result
      ..add(r'mediantime')
      ..add(serializers.serialize(object.mediantime,
          specifiedType: const FullType(int)));
    result
      ..add(r'verification_progress')
      ..add(serializers.serialize(object.verificationProgress,
          specifiedType: const FullType(num)));
    result
      ..add(r'initial_block_download')
      ..add(serializers.serialize(object.initialBlockDownload,
          specifiedType: const FullType(bool)));
    result
      ..add(r'chainwork')
      ..add(serializers.serialize(object.chainwork,
          specifiedType: const FullType(String)));
    result
      ..add(r'size_on_disk')
      ..add(serializers.serialize(object.sizeOnDisk,
          specifiedType: const FullType(int)));
    result
      ..add(r'pruned')
      ..add(serializers.serialize(object.pruned,
          specifiedType: const FullType(bool)));
    if (object.pruneHeight != null) {
      result
        ..add(r'prune_height')
        ..add(serializers.serialize(object.pruneHeight,
            specifiedType: const FullType(int)));
    }
    if (object.automaticPruning != null) {
      result
        ..add(r'automatic_pruning')
        ..add(serializers.serialize(object.automaticPruning,
            specifiedType: const FullType(bool)));
    }
    if (object.pruneTargetSize != null) {
      result
        ..add(r'prune_target_size')
        ..add(serializers.serialize(object.pruneTargetSize,
            specifiedType: const FullType(int)));
    }
    result
      ..add(r'warnings')
      ..add(serializers.serialize(object.warnings,
          specifiedType: const FullType(String)));
    result
      ..add(r'softforks')
      ..add(serializers.serialize(object.softforks,
          specifiedType: const FullType(BuiltList, [FullType(SoftFork)])));
    return result;
  }

  @override
  BlockchainInfo deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = BlockchainInfoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;

      switch (key) {
        case r'chain':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.chain = valueDes;
          break;
        case r'blocks':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.blocks = valueDes;
          break;
        case r'headers':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.headers = valueDes;
          break;
        case r'best_block_hash':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.bestBlockHash = valueDes;
          break;
        case r'difficulty':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.difficulty = valueDes;
          break;
        case r'mediantime':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.mediantime = valueDes;
          break;
        case r'verification_progress':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(num)) as num;
          result.verificationProgress = valueDes;
          break;
        case r'initial_block_download':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          result.initialBlockDownload = valueDes;
          break;
        case r'chainwork':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.chainwork = valueDes;
          break;
        case r'size_on_disk':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.sizeOnDisk = valueDes;
          break;
        case r'pruned':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          result.pruned = valueDes;
          break;
        case r'prune_height':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.pruneHeight = valueDes;
          break;
        case r'automatic_pruning':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          result.automaticPruning = valueDes;
          break;
        case r'prune_target_size':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.pruneTargetSize = valueDes;
          break;
        case r'warnings':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.warnings = valueDes;
          break;
        case r'softforks':
          final valueDes = serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, [FullType(SoftFork)]))
              as BuiltList<SoftFork>;
          result.softforks.replace(valueDes);
          break;
      }
    }
    return result.build();
  }
}
