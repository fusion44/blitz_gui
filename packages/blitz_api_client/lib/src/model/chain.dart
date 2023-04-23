//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'chain.g.dart';

/// Chain
///
/// Properties:
/// * [chain]
/// * [network]
abstract class Chain implements Built<Chain, ChainBuilder> {
  @BuiltValueField(wireName: r'chain')
  String get chain;

  @BuiltValueField(wireName: r'network')
  String get network;

  Chain._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ChainBuilder b) => b;

  factory Chain([void updates(ChainBuilder b)]) = _$Chain;

  @BuiltValueSerializer(custom: true)
  static Serializer<Chain> get serializer => _$ChainSerializer();
}

class _$ChainSerializer implements StructuredSerializer<Chain> {
  @override
  final Iterable<Type> types = const [Chain, _$Chain];

  @override
  final String wireName = r'Chain';

  @override
  Iterable<Object?> serialize(Serializers serializers, Chain object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    result
      ..add(r'chain')
      ..add(serializers.serialize(object.chain,
          specifiedType: const FullType(String)));
    result
      ..add(r'network')
      ..add(serializers.serialize(object.network,
          specifiedType: const FullType(String)));
    return result;
  }

  @override
  Chain deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = ChainBuilder();

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
        case r'network':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.network = valueDes;
          break;
      }
    }
    return result.build();
  }
}
