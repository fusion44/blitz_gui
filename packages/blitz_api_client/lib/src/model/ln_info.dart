//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:blitz_api_client/src/model/chain.dart';
import 'package:blitz_api_client/src/model/features_entry.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'ln_info.g.dart';

/// LnInfo
///
/// Properties:
/// * [implementation] - Lightning software implementation (LND, CLN)
/// * [version] - The version of the software that the node is running.
/// * [commitHash] - The SHA1 commit hash that the daemon is compiled with.
/// * [identityPubkey]
/// * [identityUri]
/// * [alias] - The alias of the node.
/// * [color] - The color of the current node in hex code format.
/// * [numPendingChannels] - Number of pending channels.
/// * [numActiveChannels] - Number of active channels.
/// * [numInactiveChannels] - Number of inactive channels.
/// * [numPeers] - Number of peers.
/// * [blockHeight] - The node's current view of the height of the best block. Only available with LND.
/// * [blockHash] - The node's current view of the hash of the best block. Only available with LND.
/// * [bestHeaderTimestamp] - Timestamp of the block best known to the wallet. Only available with LND.
/// * [syncedToChain] - Whether the wallet's view is synced to the main chain. Only available with LND.
/// * [syncedToGraph] - Whether we consider ourselves synced with the public channel graph. Only available with LND.
/// * [chains] - A list of active chains the node is connected to
/// * [uris] - The URIs of the current node.
/// * [features] - Features that our node has advertised in our init message node announcements and invoices. Not yet implemented with CLN
abstract class LnInfo implements Built<LnInfo, LnInfoBuilder> {
  /// Lightning software implementation (LND, CLN)
  @BuiltValueField(wireName: r'implementation')
  String get implementation;

  /// The version of the software that the node is running.
  @BuiltValueField(wireName: r'version')
  String get version;

  /// The SHA1 commit hash that the daemon is compiled with.
  @BuiltValueField(wireName: r'commit_hash')
  String get commitHash;

  @BuiltValueField(wireName: r'identity_pubkey')
  String? get identityPubkey;

  @BuiltValueField(wireName: r'identity_uri')
  String? get identityUri;

  /// The alias of the node.
  @BuiltValueField(wireName: r'alias')
  String get alias;

  /// The color of the current node in hex code format.
  @BuiltValueField(wireName: r'color')
  String get color;

  /// Number of pending channels.
  @BuiltValueField(wireName: r'num_pending_channels')
  int get numPendingChannels;

  /// Number of active channels.
  @BuiltValueField(wireName: r'num_active_channels')
  int get numActiveChannels;

  /// Number of inactive channels.
  @BuiltValueField(wireName: r'num_inactive_channels')
  int get numInactiveChannels;

  /// Number of peers.
  @BuiltValueField(wireName: r'num_peers')
  int get numPeers;

  /// The node's current view of the height of the best block. Only available with LND.
  @BuiltValueField(wireName: r'block_height')
  int get blockHeight;

  /// The node's current view of the hash of the best block. Only available with LND.
  @BuiltValueField(wireName: r'block_hash')
  String? get blockHash;

  /// Timestamp of the block best known to the wallet. Only available with LND.
  @BuiltValueField(wireName: r'best_header_timestamp')
  int? get bestHeaderTimestamp;

  /// Whether the wallet's view is synced to the main chain. Only available with LND.
  @BuiltValueField(wireName: r'synced_to_chain')
  bool? get syncedToChain;

  /// Whether we consider ourselves synced with the public channel graph. Only available with LND.
  @BuiltValueField(wireName: r'synced_to_graph')
  bool? get syncedToGraph;

  /// A list of active chains the node is connected to
  @BuiltValueField(wireName: r'chains')
  BuiltList<Chain>? get chains;

  /// The URIs of the current node.
  @BuiltValueField(wireName: r'uris')
  BuiltList<String>? get uris;

  /// Features that our node has advertised in our init message node announcements and invoices. Not yet implemented with CLN
  @BuiltValueField(wireName: r'features')
  BuiltList<FeaturesEntry>? get features;

  LnInfo._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LnInfoBuilder b) => b
    ..identityPubkey = 'The identity pubkey of the current node.'
    ..identityUri =
        'The complete URI (pubkey@physicaladdress:port) the current node.'
    ..blockHash = ''
    ..chains = ListBuilder()
    ..uris = ListBuilder()
    ..features = ListBuilder();

  factory LnInfo([void updates(LnInfoBuilder b)]) = _$LnInfo;

  @BuiltValueSerializer(custom: true)
  static Serializer<LnInfo> get serializer => _$LnInfoSerializer();
}

class _$LnInfoSerializer implements StructuredSerializer<LnInfo> {
  @override
  final Iterable<Type> types = const [LnInfo, _$LnInfo];

  @override
  final String wireName = r'LnInfo';

  @override
  Iterable<Object?> serialize(Serializers serializers, LnInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    result
      ..add(r'implementation')
      ..add(serializers.serialize(object.implementation,
          specifiedType: const FullType(String)));
    result
      ..add(r'version')
      ..add(serializers.serialize(object.version,
          specifiedType: const FullType(String)));
    result
      ..add(r'commit_hash')
      ..add(serializers.serialize(object.commitHash,
          specifiedType: const FullType(String)));
    if (object.identityPubkey != null) {
      result
        ..add(r'identity_pubkey')
        ..add(serializers.serialize(object.identityPubkey,
            specifiedType: const FullType(String)));
    }
    if (object.identityUri != null) {
      result
        ..add(r'identity_uri')
        ..add(serializers.serialize(object.identityUri,
            specifiedType: const FullType(String)));
    }
    result
      ..add(r'alias')
      ..add(serializers.serialize(object.alias,
          specifiedType: const FullType(String)));
    result
      ..add(r'color')
      ..add(serializers.serialize(object.color,
          specifiedType: const FullType(String)));
    result
      ..add(r'num_pending_channels')
      ..add(serializers.serialize(object.numPendingChannels,
          specifiedType: const FullType(int)));
    result
      ..add(r'num_active_channels')
      ..add(serializers.serialize(object.numActiveChannels,
          specifiedType: const FullType(int)));
    result
      ..add(r'num_inactive_channels')
      ..add(serializers.serialize(object.numInactiveChannels,
          specifiedType: const FullType(int)));
    result
      ..add(r'num_peers')
      ..add(serializers.serialize(object.numPeers,
          specifiedType: const FullType(int)));
    result
      ..add(r'block_height')
      ..add(serializers.serialize(object.blockHeight,
          specifiedType: const FullType(int)));
    if (object.blockHash != null) {
      result
        ..add(r'block_hash')
        ..add(serializers.serialize(object.blockHash,
            specifiedType: const FullType(String)));
    }
    if (object.bestHeaderTimestamp != null) {
      result
        ..add(r'best_header_timestamp')
        ..add(serializers.serialize(object.bestHeaderTimestamp,
            specifiedType: const FullType(int)));
    }
    if (object.syncedToChain != null) {
      result
        ..add(r'synced_to_chain')
        ..add(serializers.serialize(object.syncedToChain,
            specifiedType: const FullType(bool)));
    }
    if (object.syncedToGraph != null) {
      result
        ..add(r'synced_to_graph')
        ..add(serializers.serialize(object.syncedToGraph,
            specifiedType: const FullType(bool)));
    }
    if (object.chains != null) {
      result
        ..add(r'chains')
        ..add(serializers.serialize(object.chains,
            specifiedType: const FullType(BuiltList, [FullType(Chain)])));
    }
    if (object.uris != null) {
      result
        ..add(r'uris')
        ..add(serializers.serialize(object.uris,
            specifiedType: const FullType(BuiltList, [FullType(String)])));
    }
    if (object.features != null) {
      result
        ..add(r'features')
        ..add(serializers.serialize(object.features,
            specifiedType:
                const FullType(BuiltList, [FullType(FeaturesEntry)])));
    }
    return result;
  }

  @override
  LnInfo deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = LnInfoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;

      switch (key) {
        case r'implementation':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.implementation = valueDes;
          break;
        case r'version':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.version = valueDes;
          break;
        case r'commit_hash':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.commitHash = valueDes;
          break;
        case r'identity_pubkey':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.identityPubkey = valueDes;
          break;
        case r'identity_uri':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.identityUri = valueDes;
          break;
        case r'alias':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.alias = valueDes;
          break;
        case r'color':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.color = valueDes;
          break;
        case r'num_pending_channels':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.numPendingChannels = valueDes;
          break;
        case r'num_active_channels':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.numActiveChannels = valueDes;
          break;
        case r'num_inactive_channels':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.numInactiveChannels = valueDes;
          break;
        case r'num_peers':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.numPeers = valueDes;
          break;
        case r'block_height':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.blockHeight = valueDes;
          break;
        case r'block_hash':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.blockHash = valueDes;
          break;
        case r'best_header_timestamp':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.bestHeaderTimestamp = valueDes;
          break;
        case r'synced_to_chain':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          result.syncedToChain = valueDes;
          break;
        case r'synced_to_graph':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          result.syncedToGraph = valueDes;
          break;
        case r'chains':
          final valueDes = serializers.deserialize(value,
                  specifiedType: const FullType(BuiltList, [FullType(Chain)]))
              as BuiltList<Chain>;
          result.chains.replace(valueDes);
          break;
        case r'uris':
          final valueDes = serializers.deserialize(value,
                  specifiedType: const FullType(BuiltList, [FullType(String)]))
              as BuiltList<String>;
          result.uris.replace(valueDes);
          break;
        case r'features':
          final valueDes = serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, [FullType(FeaturesEntry)]))
              as BuiltList<FeaturesEntry>;
          result.features.replace(valueDes);
          break;
      }
    }
    return result.build();
  }
}
