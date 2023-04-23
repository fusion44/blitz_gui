//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:blitz_api_client/src/model/hop_hint.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'route_hint.g.dart';

/// RouteHint
///
/// Properties:
/// * [hopHints] - A list of hop hints that when chained together can assist in reaching a specific destination.
abstract class RouteHint implements Built<RouteHint, RouteHintBuilder> {
  /// A list of hop hints that when chained together can assist in reaching a specific destination.
  @BuiltValueField(wireName: r'hop_hints')
  BuiltList<HopHint>? get hopHints;

  RouteHint._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RouteHintBuilder b) => b..hopHints = ListBuilder();

  factory RouteHint([void updates(RouteHintBuilder b)]) = _$RouteHint;

  @BuiltValueSerializer(custom: true)
  static Serializer<RouteHint> get serializer => _$RouteHintSerializer();
}

class _$RouteHintSerializer implements StructuredSerializer<RouteHint> {
  @override
  final Iterable<Type> types = const [RouteHint, _$RouteHint];

  @override
  final String wireName = r'RouteHint';

  @override
  Iterable<Object?> serialize(Serializers serializers, RouteHint object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    if (object.hopHints != null) {
      result
        ..add(r'hop_hints')
        ..add(serializers.serialize(object.hopHints,
            specifiedType: const FullType(BuiltList, [FullType(HopHint)])));
    }
    return result;
  }

  @override
  RouteHint deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = RouteHintBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;

      switch (key) {
        case r'hop_hints':
          final valueDes = serializers.deserialize(value,
                  specifiedType: const FullType(BuiltList, [FullType(HopHint)]))
              as BuiltList<HopHint>;
          result.hopHints.replace(valueDes);
          break;
      }
    }
    return result.build();
  }
}
