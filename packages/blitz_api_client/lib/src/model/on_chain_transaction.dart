//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'on_chain_transaction.g.dart';

/// OnChainTransaction
///
/// Properties:
/// * [txHash] - The transaction hash
/// * [amount] - The transaction amount, denominated in satoshis
/// * [numConfirmations] - The number of confirmations
/// * [blockHeight] - The height of the block this transaction was included in
/// * [timeStamp] - Timestamp of this transaction
/// * [totalFees] - Fees paid for this transaction
/// * [destAddresses] - Addresses that received funds for this transaction
/// * [label] - An optional label that was set on transaction broadcast.
abstract class OnChainTransaction
    implements Built<OnChainTransaction, OnChainTransactionBuilder> {
  /// The transaction hash
  @BuiltValueField(wireName: r'tx_hash')
  String get txHash;

  /// The transaction amount, denominated in satoshis
  @BuiltValueField(wireName: r'amount')
  int get amount;

  /// The number of confirmations
  @BuiltValueField(wireName: r'num_confirmations')
  int get numConfirmations;

  /// The height of the block this transaction was included in
  @BuiltValueField(wireName: r'block_height')
  int get blockHeight;

  /// Timestamp of this transaction
  @BuiltValueField(wireName: r'time_stamp')
  int get timeStamp;

  /// Fees paid for this transaction
  @BuiltValueField(wireName: r'total_fees')
  int get totalFees;

  /// Addresses that received funds for this transaction
  @BuiltValueField(wireName: r'dest_addresses')
  BuiltList<String>? get destAddresses;

  /// An optional label that was set on transaction broadcast.
  @BuiltValueField(wireName: r'label')
  String? get label;

  OnChainTransaction._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OnChainTransactionBuilder b) => b
    ..destAddresses = ListBuilder()
    ..label = '';

  factory OnChainTransaction([void updates(OnChainTransactionBuilder b)]) =
      _$OnChainTransaction;

  @BuiltValueSerializer(custom: true)
  static Serializer<OnChainTransaction> get serializer =>
      _$OnChainTransactionSerializer();
}

class _$OnChainTransactionSerializer
    implements StructuredSerializer<OnChainTransaction> {
  @override
  final Iterable<Type> types = const [OnChainTransaction, _$OnChainTransaction];

  @override
  final String wireName = r'OnChainTransaction';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, OnChainTransaction object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    result
      ..add(r'tx_hash')
      ..add(serializers.serialize(object.txHash,
          specifiedType: const FullType(String)));
    result
      ..add(r'amount')
      ..add(serializers.serialize(object.amount,
          specifiedType: const FullType(int)));
    result
      ..add(r'num_confirmations')
      ..add(serializers.serialize(object.numConfirmations,
          specifiedType: const FullType(int)));
    result
      ..add(r'block_height')
      ..add(serializers.serialize(object.blockHeight,
          specifiedType: const FullType(int)));
    result
      ..add(r'time_stamp')
      ..add(serializers.serialize(object.timeStamp,
          specifiedType: const FullType(int)));
    result
      ..add(r'total_fees')
      ..add(serializers.serialize(object.totalFees,
          specifiedType: const FullType(int)));
    if (object.destAddresses != null) {
      result
        ..add(r'dest_addresses')
        ..add(serializers.serialize(object.destAddresses,
            specifiedType: const FullType(BuiltList, [FullType(String)])));
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
  OnChainTransaction deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = OnChainTransactionBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;

      switch (key) {
        case r'tx_hash':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.txHash = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.amount = valueDes;
          break;
        case r'num_confirmations':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.numConfirmations = valueDes;
          break;
        case r'block_height':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.blockHeight = valueDes;
          break;
        case r'time_stamp':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.timeStamp = valueDes;
          break;
        case r'total_fees':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.totalFees = valueDes;
          break;
        case r'dest_addresses':
          final valueDes = serializers.deserialize(value,
                  specifiedType: const FullType(BuiltList, [FullType(String)]))
              as BuiltList<String>;
          result.destAddresses.replace(valueDes);
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
