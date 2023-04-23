//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'uninstall_data.g.dart';

/// UninstallData
///
/// Properties:
/// * [keepData]
abstract class UninstallData
    implements Built<UninstallData, UninstallDataBuilder> {
  @BuiltValueField(wireName: r'keepData')
  bool? get keepData;

  UninstallData._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UninstallDataBuilder b) => b..keepData = true;

  factory UninstallData([void updates(UninstallDataBuilder b)]) =
      _$UninstallData;

  @BuiltValueSerializer(custom: true)
  static Serializer<UninstallData> get serializer =>
      _$UninstallDataSerializer();
}

class _$UninstallDataSerializer implements StructuredSerializer<UninstallData> {
  @override
  final Iterable<Type> types = const [UninstallData, _$UninstallData];

  @override
  final String wireName = r'UninstallData';

  @override
  Iterable<Object?> serialize(Serializers serializers, UninstallData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    if (object.keepData != null) {
      result
        ..add(r'keepData')
        ..add(serializers.serialize(object.keepData,
            specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  UninstallData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = UninstallDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;

      switch (key) {
        case r'keepData':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          result.keepData = valueDes;
          break;
      }
    }
    return result.build();
  }
}
