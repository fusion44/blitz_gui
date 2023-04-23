//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'unlock_wallet_input.g.dart';

/// UnlockWalletInput
///
/// Properties:
/// * [password] - The wallet password
abstract class UnlockWalletInput
    implements Built<UnlockWalletInput, UnlockWalletInputBuilder> {
  /// The wallet password
  @BuiltValueField(wireName: r'password')
  String get password;

  UnlockWalletInput._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UnlockWalletInputBuilder b) => b;

  factory UnlockWalletInput([void updates(UnlockWalletInputBuilder b)]) =
      _$UnlockWalletInput;

  @BuiltValueSerializer(custom: true)
  static Serializer<UnlockWalletInput> get serializer =>
      _$UnlockWalletInputSerializer();
}

class _$UnlockWalletInputSerializer
    implements StructuredSerializer<UnlockWalletInput> {
  @override
  final Iterable<Type> types = const [UnlockWalletInput, _$UnlockWalletInput];

  @override
  final String wireName = r'UnlockWalletInput';

  @override
  Iterable<Object?> serialize(Serializers serializers, UnlockWalletInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    result
      ..add(r'password')
      ..add(serializers.serialize(object.password,
          specifiedType: const FullType(String)));
    return result;
  }

  @override
  UnlockWalletInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = UnlockWalletInputBuilder();

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
      }
    }
    return result.build();
  }
}
