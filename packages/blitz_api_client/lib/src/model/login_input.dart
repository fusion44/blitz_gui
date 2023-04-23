//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'login_input.g.dart';

/// LoginInput
///
/// Properties:
/// * [password]
/// * [oneTimePassword]
abstract class LoginInput implements Built<LoginInput, LoginInputBuilder> {
  @BuiltValueField(wireName: r'password')
  String get password;

  @BuiltValueField(wireName: r'one_time_password')
  String? get oneTimePassword;

  LoginInput._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LoginInputBuilder b) => b;

  factory LoginInput([void updates(LoginInputBuilder b)]) = _$LoginInput;

  @BuiltValueSerializer(custom: true)
  static Serializer<LoginInput> get serializer => _$LoginInputSerializer();
}

class _$LoginInputSerializer implements StructuredSerializer<LoginInput> {
  @override
  final Iterable<Type> types = const [LoginInput, _$LoginInput];

  @override
  final String wireName = r'LoginInput';

  @override
  Iterable<Object?> serialize(Serializers serializers, LoginInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    result
      ..add(r'password')
      ..add(serializers.serialize(object.password,
          specifiedType: const FullType(String)));
    if (object.oneTimePassword != null) {
      result
        ..add(r'one_time_password')
        ..add(serializers.serialize(object.oneTimePassword,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  LoginInput deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = LoginInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;

      switch (key) {
        case r'password':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.password = valueDes;
          break;
        case r'one_time_password':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.oneTimePassword = valueDes;
          break;
      }
    }
    return result.build();
  }
}
