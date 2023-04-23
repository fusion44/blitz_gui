//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'amp_record.g.dart';

/// AMPRecord
///
/// Properties:
/// * [rootShare]
/// * [setId]
/// * [childIndex]
abstract class AMPRecord implements Built<AMPRecord, AMPRecordBuilder> {
  @BuiltValueField(wireName: r'root_share')
  String get rootShare;

  @BuiltValueField(wireName: r'set_id')
  String get setId;

  @BuiltValueField(wireName: r'child_index')
  int get childIndex;

  AMPRecord._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AMPRecordBuilder b) => b;

  factory AMPRecord([void updates(AMPRecordBuilder b)]) = _$AMPRecord;

  @BuiltValueSerializer(custom: true)
  static Serializer<AMPRecord> get serializer => _$AMPRecordSerializer();
}

class _$AMPRecordSerializer implements StructuredSerializer<AMPRecord> {
  @override
  final Iterable<Type> types = const [AMPRecord, _$AMPRecord];

  @override
  final String wireName = r'AMPRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, AMPRecord object,
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
    return result;
  }

  @override
  AMPRecord deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = AMPRecordBuilder();

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
      }
    }
    return result.build();
  }
}
