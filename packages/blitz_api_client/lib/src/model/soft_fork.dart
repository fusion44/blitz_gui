//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:blitz_api_client/src/model/bip9.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'soft_fork.g.dart';

/// SoftFork
///
/// Properties:
/// * [name] - Name of the softfork
/// * [type] - One of \"buried\", \"bip9\"
/// * [active] - True **if** the rules are enforced for the mempool and the next block
/// * [bip9]
/// * [height] - Height of the first block which the rules are or will be enforced (only for `buried` type, or `bip9` type with `active` status)
abstract class SoftFork implements Built<SoftFork, SoftForkBuilder> {
  /// Name of the softfork
  @BuiltValueField(wireName: r'name')
  String get name;

  /// One of \"buried\", \"bip9\"
  @BuiltValueField(wireName: r'type')
  String get type;

  /// True **if** the rules are enforced for the mempool and the next block
  @BuiltValueField(wireName: r'active')
  bool get active;

  @BuiltValueField(wireName: r'bip9')
  Bip9? get bip9;

  /// Height of the first block which the rules are or will be enforced (only for `buried` type, or `bip9` type with `active` status)
  @BuiltValueField(wireName: r'height')
  int? get height;

  SoftFork._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SoftForkBuilder b) => b;

  factory SoftFork([void updates(SoftForkBuilder b)]) = _$SoftFork;

  @BuiltValueSerializer(custom: true)
  static Serializer<SoftFork> get serializer => _$SoftForkSerializer();
}

class _$SoftForkSerializer implements StructuredSerializer<SoftFork> {
  @override
  final Iterable<Type> types = const [SoftFork, _$SoftFork];

  @override
  final String wireName = r'SoftFork';

  @override
  Iterable<Object?> serialize(Serializers serializers, SoftFork object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    result
      ..add(r'name')
      ..add(serializers.serialize(object.name,
          specifiedType: const FullType(String)));
    result
      ..add(r'type')
      ..add(serializers.serialize(object.type,
          specifiedType: const FullType(String)));
    result
      ..add(r'active')
      ..add(serializers.serialize(object.active,
          specifiedType: const FullType(bool)));
    if (object.bip9 != null) {
      result
        ..add(r'bip9')
        ..add(serializers.serialize(object.bip9,
            specifiedType: const FullType(Bip9)));
    }
    if (object.height != null) {
      result
        ..add(r'height')
        ..add(serializers.serialize(object.height,
            specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  SoftFork deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = SoftForkBuilder();

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
        case r'type':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.type = valueDes;
          break;
        case r'active':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          result.active = valueDes;
          break;
        case r'bip9':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(Bip9)) as Bip9;
          result.bip9.replace(valueDes);
          break;
        case r'height':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.height = valueDes;
          break;
      }
    }
    return result.build();
  }
}
