//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hop.g.dart';

/// Hop
///
/// Properties:
/// * [chanId]
/// * [chanCapacity]
/// * [amtToForward]
/// * [fee]
/// * [expiry]
/// * [amtToForwardMsat]
/// * [feeMsat]
/// * [pubKey]
/// * [tlvPayload]
abstract class Hop implements Built<Hop, HopBuilder> {
  @BuiltValueField(wireName: r'chan_id')
  int get chanId;

  @BuiltValueField(wireName: r'chan_capacity')
  int get chanCapacity;

  @BuiltValueField(wireName: r'amt_to_forward')
  int get amtToForward;

  @BuiltValueField(wireName: r'fee')
  int get fee;

  @BuiltValueField(wireName: r'expiry')
  int get expiry;

  @BuiltValueField(wireName: r'amt_to_forward_msat')
  int get amtToForwardMsat;

  @BuiltValueField(wireName: r'fee_msat')
  int get feeMsat;

  @BuiltValueField(wireName: r'pub_key')
  String get pubKey;

  @BuiltValueField(wireName: r'tlv_payload')
  bool get tlvPayload;

  Hop._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HopBuilder b) => b;

  factory Hop([void updates(HopBuilder b)]) = _$Hop;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hop> get serializer => _$HopSerializer();
}

class _$HopSerializer implements StructuredSerializer<Hop> {
  @override
  final Iterable<Type> types = const [Hop, _$Hop];

  @override
  final String wireName = r'Hop';

  @override
  Iterable<Object?> serialize(Serializers serializers, Hop object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    result
      ..add(r'chan_id')
      ..add(serializers.serialize(object.chanId,
          specifiedType: const FullType(int)));
    result
      ..add(r'chan_capacity')
      ..add(serializers.serialize(object.chanCapacity,
          specifiedType: const FullType(int)));
    result
      ..add(r'amt_to_forward')
      ..add(serializers.serialize(object.amtToForward,
          specifiedType: const FullType(int)));
    result
      ..add(r'fee')
      ..add(serializers.serialize(object.fee,
          specifiedType: const FullType(int)));
    result
      ..add(r'expiry')
      ..add(serializers.serialize(object.expiry,
          specifiedType: const FullType(int)));
    result
      ..add(r'amt_to_forward_msat')
      ..add(serializers.serialize(object.amtToForwardMsat,
          specifiedType: const FullType(int)));
    result
      ..add(r'fee_msat')
      ..add(serializers.serialize(object.feeMsat,
          specifiedType: const FullType(int)));
    result
      ..add(r'pub_key')
      ..add(serializers.serialize(object.pubKey,
          specifiedType: const FullType(String)));
    result
      ..add(r'tlv_payload')
      ..add(serializers.serialize(object.tlvPayload,
          specifiedType: const FullType(bool)));
    return result;
  }

  @override
  Hop deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = HopBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;

      switch (key) {
        case r'chan_id':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.chanId = valueDes;
          break;
        case r'chan_capacity':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.chanCapacity = valueDes;
          break;
        case r'amt_to_forward':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.amtToForward = valueDes;
          break;
        case r'fee':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.fee = valueDes;
          break;
        case r'expiry':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.expiry = valueDes;
          break;
        case r'amt_to_forward_msat':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.amtToForwardMsat = valueDes;
          break;
        case r'fee_msat':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.feeMsat = valueDes;
          break;
        case r'pub_key':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.pubKey = valueDes;
          break;
        case r'tlv_payload':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          result.tlvPayload = valueDes;
          break;
      }
    }
    return result.build();
  }
}
