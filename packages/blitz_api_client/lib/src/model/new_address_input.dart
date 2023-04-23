//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:blitz_api_client/src/model/onchain_address_type.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'new_address_input.g.dart';

/// NewAddressInput
///
/// Properties:
/// * [type] -  Address-types has to be one of: * p2wkh:  Pay to witness key hash (bech32) * np2wkh: Pay to nested witness key hash
abstract class NewAddressInput
    implements Built<NewAddressInput, NewAddressInputBuilder> {
  ///  Address-types has to be one of: * p2wkh:  Pay to witness key hash (bech32) * np2wkh: Pay to nested witness key hash
  @BuiltValueField(wireName: r'type')
  OnchainAddressType? get type;

  NewAddressInput._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NewAddressInputBuilder b) => b;

  factory NewAddressInput([void updates(NewAddressInputBuilder b)]) =
      _$NewAddressInput;

  @BuiltValueSerializer(custom: true)
  static Serializer<NewAddressInput> get serializer =>
      _$NewAddressInputSerializer();
}

class _$NewAddressInputSerializer
    implements StructuredSerializer<NewAddressInput> {
  @override
  final Iterable<Type> types = const [NewAddressInput, _$NewAddressInput];

  @override
  final String wireName = r'NewAddressInput';

  @override
  Iterable<Object?> serialize(Serializers serializers, NewAddressInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    result
      ..add(r'type')
      ..add(object.type == null
          ? null
          : serializers.serialize(object.type,
              specifiedType: const FullType.nullable(OnchainAddressType)));
    return result;
  }

  @override
  NewAddressInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = NewAddressInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;

      switch (key) {
        case r'type':
          final valueDes = serializers.deserialize(value,
                  specifiedType: const FullType.nullable(OnchainAddressType))
              as OnchainAddressType?;
          if (valueDes == null) continue;
          result.type = valueDes;
          break;
      }
    }
    return result.build();
  }
}
