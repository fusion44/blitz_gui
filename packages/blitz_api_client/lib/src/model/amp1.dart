//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:blitz_api_client/src/model/amp.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'amp1.g.dart';

/// Details relevant to AMP HTLCs, only populated if this is an AMP HTLC.
///
/// Properties:
/// * [rootShare]
/// * [setId]
/// * [childIndex]
/// * [hash]
/// * [preimage]
abstract class Amp1 implements Built<Amp1, Amp1Builder> {
  @BuiltValueField(wireName: r'root_share')
  String get rootShare;

  @BuiltValueField(wireName: r'set_id')
  String get setId;

  @BuiltValueField(wireName: r'child_index')
  int get childIndex;

  @BuiltValueField(wireName: r'hash')
  String get hash;

  @BuiltValueField(wireName: r'preimage')
  String get preimage;

  Amp1._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Amp1Builder b) => b;

  factory Amp1([void updates(Amp1Builder b)]) = _$Amp1;

  @BuiltValueSerializer(custom: true)
  static Serializer<Amp1> get serializer => _$Amp1Serializer();
}

class _$Amp1Serializer implements StructuredSerializer<Amp1> {
  @override
  final Iterable<Type> types = const [Amp1, _$Amp1];

  @override
  final String wireName = r'Amp1';

  @override
  Iterable<Object?> serialize(Serializers serializers, Amp1 object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    result
      ..add(r'root_share')
      ..add(serializers.serialize(object.rootShare,
          specifiedType: const FullType(String)));
    result
      ..add(r'set_id')
      ..add(serializers.serialize(object.setId,
          specifiedType: const FullType(String)));
    result
      ..add(r'child_index')
      ..add(serializers.serialize(object.childIndex,
          specifiedType: const FullType(int)));
    result
      ..add(r'hash')
      ..add(serializers.serialize(object.hash,
          specifiedType: const FullType(String)));
    result
      ..add(r'preimage')
      ..add(serializers.serialize(object.preimage,
          specifiedType: const FullType(String)));
    return result;
  }

  @override
  Amp1 deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = Amp1Builder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;

      switch (key) {
        case r'root_share':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.rootShare = valueDes;
          break;
        case r'set_id':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.setId = valueDes;
          break;
        case r'child_index':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.childIndex = valueDes;
          break;
        case r'hash':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.hash = valueDes;
          break;
        case r'preimage':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.preimage = valueDes;
          break;
      }
    }
    return result.build();
  }
}
