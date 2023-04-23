//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'custom_records_entry.g.dart';

/// CustomRecordsEntry
///
/// Properties:
/// * [key]
/// * [value]
abstract class CustomRecordsEntry
    implements Built<CustomRecordsEntry, CustomRecordsEntryBuilder> {
  @BuiltValueField(wireName: r'key')
  int get key;

  @BuiltValueField(wireName: r'value')
  String get value;

  CustomRecordsEntry._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CustomRecordsEntryBuilder b) => b;

  factory CustomRecordsEntry([void updates(CustomRecordsEntryBuilder b)]) =
      _$CustomRecordsEntry;

  @BuiltValueSerializer(custom: true)
  static Serializer<CustomRecordsEntry> get serializer =>
      _$CustomRecordsEntrySerializer();
}

class _$CustomRecordsEntrySerializer
    implements StructuredSerializer<CustomRecordsEntry> {
  @override
  final Iterable<Type> types = const [CustomRecordsEntry, _$CustomRecordsEntry];

  @override
  final String wireName = r'CustomRecordsEntry';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, CustomRecordsEntry object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    result
      ..add(r'key')
      ..add(serializers.serialize(object.key,
          specifiedType: const FullType(int)));
    result
      ..add(r'value')
      ..add(serializers.serialize(object.value,
          specifiedType: const FullType(String)));
    return result;
  }

  @override
  CustomRecordsEntry deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = CustomRecordsEntryBuilder();

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
              specifiedType: const FullType(String)) as String;
          result.value = valueDes;
          break;
      }
    }
    return result.build();
  }
}
