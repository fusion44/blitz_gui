//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'channel.g.dart';

/// Channel
///
/// Properties:
/// * [channelId]
/// * [active]
/// * [peerPublickey]
/// * [peerAlias]
/// * [balanceLocal]
/// * [balanceRemote]
/// * [balanceCapacity]
abstract class Channel implements Built<Channel, ChannelBuilder> {
  @BuiltValueField(wireName: r'channel_id')
  String? get channelId;

  @BuiltValueField(wireName: r'active')
  bool? get active;

  @BuiltValueField(wireName: r'peer_publickey')
  String? get peerPublickey;

  @BuiltValueField(wireName: r'peer_alias')
  String? get peerAlias;

  @BuiltValueField(wireName: r'balance_local')
  int? get balanceLocal;

  @BuiltValueField(wireName: r'balance_remote')
  int? get balanceRemote;

  @BuiltValueField(wireName: r'balance_capacity')
  int? get balanceCapacity;

  Channel._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ChannelBuilder b) => b;

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
    if (object.active != null) {
      result
        ..add(r'active')
        ..add(serializers.serialize(object.active,
            specifiedType: const FullType(bool)));
    }
    if (object.peerPublickey != null) {
      result
        ..add(r'peer_publickey')
        ..add(serializers.serialize(object.peerPublickey,
            specifiedType: const FullType(String)));
    }
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
      }
    }
    return result.build();
  }
}
