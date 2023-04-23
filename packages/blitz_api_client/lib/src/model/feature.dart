//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'feature.g.dart';

/// Feature
///
/// Properties:
/// * [name]
/// * [isRequired]
/// * [isKnown]
abstract class Feature implements Built<Feature, FeatureBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'is_required')
  bool? get isRequired;

  @BuiltValueField(wireName: r'is_known')
  bool? get isKnown;

  Feature._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FeatureBuilder b) => b;

  factory Feature([void updates(FeatureBuilder b)]) = _$Feature;

  @BuiltValueSerializer(custom: true)
  static Serializer<Feature> get serializer => _$FeatureSerializer();
}

class _$FeatureSerializer implements StructuredSerializer<Feature> {
  @override
  final Iterable<Type> types = const [Feature, _$Feature];

  @override
  final String wireName = r'Feature';

  @override
  Iterable<Object?> serialize(Serializers serializers, Feature object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    result
      ..add(r'name')
      ..add(serializers.serialize(object.name,
          specifiedType: const FullType(String)));
    if (object.isRequired != null) {
      result
        ..add(r'is_required')
        ..add(serializers.serialize(object.isRequired,
            specifiedType: const FullType(bool)));
    }
    if (object.isKnown != null) {
      result
        ..add(r'is_known')
        ..add(serializers.serialize(object.isKnown,
            specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  Feature deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = FeatureBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;

      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.name = valueDes;
          break;
        case r'is_required':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          result.isRequired = valueDes;
          break;
        case r'is_known':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          result.isKnown = valueDes;
          break;
      }
    }
    return result.build();
  }
}
