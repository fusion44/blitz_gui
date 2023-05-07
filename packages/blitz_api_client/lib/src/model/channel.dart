//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:blitz_api_client/src/model/channel_initiator.dart';
import 'package:blitz_api_client/src/model/channel_state.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'channel.g.dart';

/// Channel
///
/// Properties:
/// * [channelId] - The unique identifier of the channel
/// * [state] - The state of the channel
/// * [active] - Whether the channel is active or not. True if the channel is not closing and the peer is online.
/// * [peerPublickey] - The public key of the peer
/// * [peerAlias] - The alias of the peer if available
/// * [balanceLocal] - This node's current balance in this channel
/// * [balanceRemote] - The counterparty's current balance in this channel
/// * [balanceCapacity] - The total capacity of the channel
/// * [dualFunded] - Whether the channel was dual funded or not
/// * [initiator] - Whether the channel was initiated by us, our peer or both
/// * [closer] - If state is closing, this shows who initiated the close. None, if not in a closing state.
abstract class Channel implements Built<Channel, ChannelBuilder> {
  /// The unique identifier of the channel
  @BuiltValueField(wireName: r'channel_id')
  String? get channelId;

  /// The state of the channel
  @BuiltValueField(wireName: r'state')
  ChannelState? get state;

  /// Whether the channel is active or not. True if the channel is not closing and the peer is online.
  @BuiltValueField(wireName: r'active')
  bool get active;

  /// The public key of the peer
  @BuiltValueField(wireName: r'peer_publickey')
  String get peerPublickey;

  /// The alias of the peer if available
  @BuiltValueField(wireName: r'peer_alias')
  String? get peerAlias;

  /// This node's current balance in this channel
  @BuiltValueField(wireName: r'balance_local')
  int? get balanceLocal;

  /// The counterparty's current balance in this channel
  @BuiltValueField(wireName: r'balance_remote')
  int? get balanceRemote;

  /// The total capacity of the channel
  @BuiltValueField(wireName: r'balance_capacity')
  int? get balanceCapacity;

  /// Whether the channel was dual funded or not
  @BuiltValueField(wireName: r'dual_funded')
  bool? get dualFunded;

  /// Whether the channel was initiated by us, our peer or both
  @BuiltValueField(wireName: r'initiator')
  ChannelInitiator? get initiator;

  /// If state is closing, this shows who initiated the close. None, if not in a closing state.
  @BuiltValueField(wireName: r'closer')
  ChannelInitiator? get closer;

  Channel._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ChannelBuilder b) => b
    ..channelId = ''
    ..peerAlias = ''
    ..balanceLocal = 0
    ..balanceRemote = 0
    ..balanceCapacity = 0;

  factory Channel([void updates(ChannelBuilder b)]) = _$Channel;

  @BuiltValueSerializer(custom: true)
  static Serializer<Channel> get serializer => _$ChannelSerializer();
}

class _$ChannelSerializer implements StructuredSerializer<Channel> {
  @override
  final Iterable<Type> types = const [Channel, _$Channel];

  @override
  final String wireName = r'Channel';

  @override
  Iterable<Object?> serialize(Serializers serializers, Channel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    if (object.channelId != null) {
      result
        ..add(r'channel_id')
        ..add(serializers.serialize(object.channelId,
            specifiedType: const FullType(String)));
    }
    result
      ..add(r'state')
      ..add(object.state == null
          ? null
          : serializers.serialize(object.state,
              specifiedType: const FullType.nullable(ChannelState)));
    result
      ..add(r'active')
      ..add(serializers.serialize(object.active,
          specifiedType: const FullType(bool)));
    result
      ..add(r'peer_publickey')
      ..add(serializers.serialize(object.peerPublickey,
          specifiedType: const FullType(String)));
    if (object.peerAlias != null) {
      result
        ..add(r'peer_alias')
        ..add(serializers.serialize(object.peerAlias,
            specifiedType: const FullType(String)));
    }
    if (object.balanceLocal != null) {
      result
        ..add(r'balance_local')
        ..add(serializers.serialize(object.balanceLocal,
            specifiedType: const FullType(int)));
    }
    if (object.balanceRemote != null) {
      result
        ..add(r'balance_remote')
        ..add(serializers.serialize(object.balanceRemote,
            specifiedType: const FullType(int)));
    }
    if (object.balanceCapacity != null) {
      result
        ..add(r'balance_capacity')
        ..add(serializers.serialize(object.balanceCapacity,
            specifiedType: const FullType(int)));
    }
    if (object.dualFunded != null) {
      result
        ..add(r'dual_funded')
        ..add(serializers.serialize(object.dualFunded,
            specifiedType: const FullType(bool)));
    }
    if (object.initiator != null) {
      result
        ..add(r'initiator')
        ..add(serializers.serialize(object.initiator,
            specifiedType: const FullType.nullable(ChannelInitiator)));
    }
    if (object.closer != null) {
      result
        ..add(r'closer')
        ..add(serializers.serialize(object.closer,
            specifiedType: const FullType.nullable(ChannelInitiator)));
    }
    return result;
  }

  @override
  Channel deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = ChannelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;

      switch (key) {
        case r'channel_id':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.channelId = valueDes;
          break;
        case r'state':
          final valueDes = serializers.deserialize(value,
                  specifiedType: const FullType.nullable(ChannelState))
              as ChannelState?;
          if (valueDes == null) continue;
          result.state = valueDes;
          break;
        case r'active':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          result.active = valueDes;
          break;
        case r'peer_publickey':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.peerPublickey = valueDes;
          break;
        case r'peer_alias':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.peerAlias = valueDes;
          break;
        case r'balance_local':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.balanceLocal = valueDes;
          break;
        case r'balance_remote':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.balanceRemote = valueDes;
          break;
        case r'balance_capacity':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.balanceCapacity = valueDes;
          break;
        case r'dual_funded':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          result.dualFunded = valueDes;
          break;
        case r'initiator':
          final valueDes = serializers.deserialize(value,
                  specifiedType: const FullType.nullable(ChannelInitiator))
              as ChannelInitiator?;
          if (valueDes == null) continue;
          result.initiator = valueDes;
          break;
        case r'closer':
          final valueDes = serializers.deserialize(value,
                  specifiedType: const FullType.nullable(ChannelInitiator))
              as ChannelInitiator?;
          if (valueDes == null) continue;
          result.closer = valueDes;
          break;
      }
    }
    return result.build();
  }
}
