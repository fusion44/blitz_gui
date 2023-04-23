//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'send_coins_input.g.dart';

/// SendCoinsInput
///
/// Properties:
/// * [address] - The base58 or bech32 encoded bitcoin address to send coins to on-chain
/// * [targetConf] - The number of blocks that the transaction *should* confirm in, will be used for fee estimation
/// * [satPerVbyte] - A manual fee expressed in sat/vbyte that should be used when crafting the transaction (default: 0)
/// * [minConfs] - The minimum number of confirmations each one of your outputs used for the transaction must satisfy
/// * [label] - A label for the transaction. Ignored by CLN backend.
/// * [sendAll] - Send all available on-chain funds from the wallet. Will be executed `amount` is **0**
/// * [amount] - The number of bitcoin denominated in satoshis to send. Must not be set when `send_all` is true.
abstract class SendCoinsInput
    implements Built<SendCoinsInput, SendCoinsInputBuilder> {
  /// The base58 or bech32 encoded bitcoin address to send coins to on-chain
  @BuiltValueField(wireName: r'address')
  String get address;

  /// The number of blocks that the transaction *should* confirm in, will be used for fee estimation
  @BuiltValueField(wireName: r'target_conf')
  int? get targetConf;

  /// A manual fee expressed in sat/vbyte that should be used when crafting the transaction (default: 0)
  @BuiltValueField(wireName: r'sat_per_vbyte')
  int? get satPerVbyte;

  /// The minimum number of confirmations each one of your outputs used for the transaction must satisfy
  @BuiltValueField(wireName: r'min_confs')
  int? get minConfs;

  /// A label for the transaction. Ignored by CLN backend.
  @BuiltValueField(wireName: r'label')
  String? get label;

  /// Send all available on-chain funds from the wallet. Will be executed `amount` is **0**
  @BuiltValueField(wireName: r'send_all')
  bool? get sendAll;

  /// The number of bitcoin denominated in satoshis to send. Must not be set when `send_all` is true.
  @BuiltValueField(wireName: r'amount')
  int? get amount;

  SendCoinsInput._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SendCoinsInputBuilder b) => b
    ..minConfs = 1
    ..label = ''
    ..sendAll = false
    ..amount = 0;

  factory SendCoinsInput([void updates(SendCoinsInputBuilder b)]) =
      _$SendCoinsInput;

  @BuiltValueSerializer(custom: true)
  static Serializer<SendCoinsInput> get serializer =>
      _$SendCoinsInputSerializer();
}

class _$SendCoinsInputSerializer
    implements StructuredSerializer<SendCoinsInput> {
  @override
  final Iterable<Type> types = const [SendCoinsInput, _$SendCoinsInput];

  @override
  final String wireName = r'SendCoinsInput';

  @override
  Iterable<Object?> serialize(Serializers serializers, SendCoinsInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    result
      ..add(r'address')
      ..add(serializers.serialize(object.address,
          specifiedType: const FullType(String)));
    if (object.targetConf != null) {
      result
        ..add(r'target_conf')
        ..add(serializers.serialize(object.targetConf,
            specifiedType: const FullType(int)));
    }
    if (object.satPerVbyte != null) {
      result
        ..add(r'sat_per_vbyte')
        ..add(serializers.serialize(object.satPerVbyte,
            specifiedType: const FullType(int)));
    }
    if (object.minConfs != null) {
      result
        ..add(r'min_confs')
        ..add(serializers.serialize(object.minConfs,
            specifiedType: const FullType(int)));
    }
    if (object.label != null) {
      result
        ..add(r'label')
        ..add(serializers.serialize(object.label,
            specifiedType: const FullType(String)));
    }
    if (object.sendAll != null) {
      result
        ..add(r'send_all')
        ..add(serializers.serialize(object.sendAll,
            specifiedType: const FullType(bool)));
    }
    if (object.amount != null) {
      result
        ..add(r'amount')
        ..add(serializers.serialize(object.amount,
            specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  SendCoinsInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = SendCoinsInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;

      switch (key) {
        case r'address':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.address = valueDes;
          break;
        case r'target_conf':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.targetConf = valueDes;
          break;
        case r'sat_per_vbyte':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.satPerVbyte = valueDes;
          break;
        case r'min_confs':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.minConfs = valueDes;
          break;
        case r'label':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.label = valueDes;
          break;
        case r'send_all':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          result.sendAll = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.amount = valueDes;
          break;
      }
    }
    return result.build();
  }
}
