//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:blitz_api_client/src/model/feature.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'features_entry.g.dart';

/// FeaturesEntry
///
/// Properties:
/// * [key]
/// * [value]
abstract class FeaturesEntry
    implements Built<FeaturesEntry, FeaturesEntryBuilder> {
  @BuiltValueField(wireName: r'key')
  int get key;

  @BuiltValueField(wireName: r'value')
  Feature get value;

  FeaturesEntry._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FeaturesEntryBuilder b) => b;

  factory FeaturesEntry([void updates(FeaturesEntryBuilder b)]) =
      _$FeaturesEntry;

  @BuiltValueSerializer(custom: true)
  static Serializer<FeaturesEntry> get serializer =>
      _$FeaturesEntrySerializer();
}

class _$FeaturesEntrySerializer implements StructuredSerializer<FeaturesEntry> {
  @override
  final Iterable<Type> types = const [FeaturesEntry, _$FeaturesEntry];

  @override
  final String wireName = r'FeaturesEntry';

  @override
  Iterable<Object?> serialize(Serializers serializers, FeaturesEntry object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    result
      ..add(r'key')
      ..add(serializers.serialize(object.key,
          specifiedType: const FullType(int)));
    result
      ..add(r'value')
      ..add(serializers.serialize(object.value,
          specifiedType: const FullType(Feature)));
    return result;
  }

  @override
  FeaturesEntry deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = FeaturesEntryBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;

      switch (key) {
        case r'key':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.key = valueDes;
          break;
        case r'value':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(Feature)) as Feature;
          result.value.replace(valueDes);
          break;
      }
    }
    return result.build();
  }
}
