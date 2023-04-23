//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'lightning_info_lite.g.dart';

/// LightningInfoLite
///
/// Properties:
/// * [implementation] - Lightning software implementation (LND, c-lightning)
/// * [version] - Version of the implementation
/// * [identityPubkey] - The identity pubkey of the current node
/// * [identityUri] - The complete URI of the current node
/// * [numPendingChannels] - Number of pending channels
/// * [numActiveChannels] - Number of active channels
/// * [numInactiveChannels] - Number of inactive channels
/// * [numPeers] - Number of peers
/// * [blockHeight] - The node's current view of the height of the best block
/// * [syncedToChain] - Whether the wallet's view is synced to the main chain
/// * [syncedToGraph] - Whether we consider ourselves synced with the public channel graph.
abstract class LightningInfoLite
    implements Built<LightningInfoLite, LightningInfoLiteBuilder> {
  /// Lightning software implementation (LND, c-lightning)
  @BuiltValueField(wireName: r'implementation')
  String get implementation;

  /// Version of the implementation
  @BuiltValueField(wireName: r'version')
  String get version;

  /// The identity pubkey of the current node
  @BuiltValueField(wireName: r'identity_pubkey')
  String get identityPubkey;

  /// The complete URI of the current node
  @BuiltValueField(wireName: r'identity_uri')
  String get identityUri;

  /// Number of pending channels
  @BuiltValueField(wireName: r'num_pending_channels')
  int get numPendingChannels;

  /// Number of active channels
  @BuiltValueField(wireName: r'num_active_channels')
  int get numActiveChannels;

  /// Number of inactive channels
  @BuiltValueField(wireName: r'num_inactive_channels')
  int get numInactiveChannels;

  /// Number of peers
  @BuiltValueField(wireName: r'num_peers')
  int get numPeers;

  /// The node's current view of the height of the best block
  @BuiltValueField(wireName: r'block_height')
  int get blockHeight;

  /// Whether the wallet's view is synced to the main chain
  @BuiltValueField(wireName: r'synced_to_chain')
  bool? get syncedToChain;

  /// Whether we consider ourselves synced with the public channel graph.
  @BuiltValueField(wireName: r'synced_to_graph')
  bool? get syncedToGraph;

  LightningInfoLite._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LightningInfoLiteBuilder b) => b;

  factory LightningInfoLite([void updates(LightningInfoLiteBuilder b)]) =
      _$LightningInfoLite;

  @BuiltValueSerializer(custom: true)
  static Serializer<LightningInfoLite> get serializer =>
      _$LightningInfoLiteSerializer();
}

class _$LightningInfoLiteSerializer
    implements StructuredSerializer<LightningInfoLite> {
  @override
  final Iterable<Type> types = const [LightningInfoLite, _$LightningInfoLite];

  @override
  final String wireName = r'LightningInfoLite';

  @override
  Iterable<Object?> serialize(Serializers serializers, LightningInfoLite object,
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
      ..add(r'identity_pubkey')
      ..add(serializers.serialize(object.identityPubkey,
          specifiedType: const FullType(String)));
    result
      ..add(r'identity_uri')
      ..add(serializers.serialize(object.identityUri,
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
    return result;
  }

  @override
  LightningInfoLite deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = LightningInfoLiteBuilder();

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
      }
    }
    return result.build();
  }
}
