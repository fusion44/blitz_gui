//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'send_coins_response.g.dart';

/// SendCoinsResponse
///
/// Properties:
/// * [txid] - The transaction ID for this onchain payment
/// * [address] - The base58 or bech32 encoded bitcoin address where the onchain funds where sent to
/// * [amount] - The number of bitcoin denominated in satoshis which where sent
/// * [fees] - The number of bitcoin denominated in satoshis which where paid as fees
/// * [label] - The label used for the transaction. Ignored by CLN backend.
abstract class SendCoinsResponse
    implements Built<SendCoinsResponse, SendCoinsResponseBuilder> {
  /// The transaction ID for this onchain payment
  @BuiltValueField(wireName: r'txid')
  String get txid;

  /// The base58 or bech32 encoded bitcoin address where the onchain funds where sent to
  @BuiltValueField(wireName: r'address')
  String get address;

  /// The number of bitcoin denominated in satoshis which where sent
  @BuiltValueField(wireName: r'amount')
  int get amount;

  /// The number of bitcoin denominated in satoshis which where paid as fees
  @BuiltValueField(wireName: r'fees')
  int? get fees;

  /// The label used for the transaction. Ignored by CLN backend.
  @BuiltValueField(wireName: r'label')
  String? get label;

  SendCoinsResponse._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SendCoinsResponseBuilder b) => b..label = '';

  factory SendCoinsResponse([void updates(SendCoinsResponseBuilder b)]) =
      _$SendCoinsResponse;

  @BuiltValueSerializer(custom: true)
  static Serializer<SendCoinsResponse> get serializer =>
      _$SendCoinsResponseSerializer();
}

class _$SendCoinsResponseSerializer
    implements StructuredSerializer<SendCoinsResponse> {
  @override
  final Iterable<Type> types = const [SendCoinsResponse, _$SendCoinsResponse];

  @override
  final String wireName = r'SendCoinsResponse';

  @override
  Iterable<Object?> serialize(Serializers serializers, SendCoinsResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    result
      ..add(r'txid')
      ..add(serializers.serialize(object.txid,
          specifiedType: const FullType(String)));
    result
      ..add(r'address')
      ..add(serializers.serialize(object.address,
          specifiedType: const FullType(String)));
    result
      ..add(r'amount')
      ..add(serializers.serialize(object.amount,
          specifiedType: const FullType(int)));
    if (object.fees != null) {
      result
        ..add(r'fees')
        ..add(serializers.serialize(object.fees,
            specifiedType: const FullType(int)));
    }
    if (object.label != null) {
      result
        ..add(r'label')
        ..add(serializers.serialize(object.label,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  SendCoinsResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = SendCoinsResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;

      switch (key) {
        case r'txid':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.txid = valueDes;
          break;
        case r'address':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.address = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.amount = valueDes;
          break;
        case r'fees':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.fees = valueDes;
          break;
        case r'label':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.label = valueDes;
          break;
      }
    }
    return result.build();
  }
}
