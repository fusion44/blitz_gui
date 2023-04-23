//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hop_hint.g.dart';

/// HopHint
///
/// Properties:
/// * [nodeId] - The public key of the node at the start of the channel.
/// * [chanId] - The unique identifier of the channel.
/// * [feeBaseMsat] - The base fee of the channel denominated in msat.
/// * [feeProportionalMillionths] - The fee rate of the channel for sending one satoshi across it denominated in msat
/// * [cltvExpiryDelta] - The time-lock delta of the channel.
abstract class HopHint implements Built<HopHint, HopHintBuilder> {
  /// The public key of the node at the start of the channel.
  @BuiltValueField(wireName: r'node_id')
  String get nodeId;

  /// The unique identifier of the channel.
  @BuiltValueField(wireName: r'chan_id')
  String get chanId;

  /// The base fee of the channel denominated in msat.
  @BuiltValueField(wireName: r'fee_base_msat')
  int get feeBaseMsat;

  /// The fee rate of the channel for sending one satoshi across it denominated in msat
  @BuiltValueField(wireName: r'fee_proportional_millionths')
  int get feeProportionalMillionths;

  /// The time-lock delta of the channel.
  @BuiltValueField(wireName: r'cltv_expiry_delta')
  int get cltvExpiryDelta;

  HopHint._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HopHintBuilder b) => b;

  factory HopHint([void updates(HopHintBuilder b)]) = _$HopHint;

  @BuiltValueSerializer(custom: true)
  static Serializer<HopHint> get serializer => _$HopHintSerializer();
}

class _$HopHintSerializer implements StructuredSerializer<HopHint> {
  @override
  final Iterable<Type> types = const [HopHint, _$HopHint];

  @override
  final String wireName = r'HopHint';

  @override
  Iterable<Object?> serialize(Serializers serializers, HopHint object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    result
      ..add(r'node_id')
      ..add(serializers.serialize(object.nodeId,
          specifiedType: const FullType(String)));
    result
      ..add(r'chan_id')
      ..add(serializers.serialize(object.chanId,
          specifiedType: const FullType(String)));
    result
      ..add(r'fee_base_msat')
      ..add(serializers.serialize(object.feeBaseMsat,
          specifiedType: const FullType(int)));
    result
      ..add(r'fee_proportional_millionths')
      ..add(serializers.serialize(object.feeProportionalMillionths,
          specifiedType: const FullType(int)));
    result
      ..add(r'cltv_expiry_delta')
      ..add(serializers.serialize(object.cltvExpiryDelta,
          specifiedType: const FullType(int)));
    return result;
  }

  @override
  HopHint deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = HopHintBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;

      switch (key) {
        case r'node_id':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.nodeId = valueDes;
          break;
        case r'chan_id':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.chanId = valueDes;
          break;
        case r'fee_base_msat':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.feeBaseMsat = valueDes;
          break;
        case r'fee_proportional_millionths':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.feeProportionalMillionths = valueDes;
          break;
        case r'cltv_expiry_delta':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.cltvExpiryDelta = valueDes;
          break;
      }
    }
    return result.build();
  }
}
