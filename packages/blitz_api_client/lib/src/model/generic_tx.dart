//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:blitz_api_client/src/model/tx_category.dart';
import 'package:blitz_api_client/src/model/tx_status.dart';
import 'package:blitz_api_client/src/model/tx_type.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'generic_tx.g.dart';

/// GenericTx
///
/// Properties:
/// * [index] - The index of the transaction.
/// * [id] -  Unique identifier for this transaction.  Depending on the type of the transaction it will be different: #### On-chain The transaction hash  #### Lightning Invoice and Payment The payment request
/// * [category] - Whether this is an onchain (**onchain**) or lightning (**ln**) transaction.
/// * [type] - Whether this is an outgoing (**send**) transaction or an incoming (**receive**) transaction.
/// * [amount] -  The value of the transaction, depending on the category in satoshis or millisatoshis.  #### On-chain Transaction amount in satoshis  #### Lightning Invoice * value in millisatoshis of the invoice if *unsettled* * amount in millisatoshis paid if invoice is *settled*  #### Lightning Payment * amount sent in millisatoshis
/// * [timeStamp] -  The unix timestamp in seconds for the transaction.  The timestamp can mean different things in different situations:  #### Lightning Invoice * Creation date for in-flight or failed invoices * Settle date for succeeded invoices  #### On-chain * Creation date for transaction waiting in the mempool * Timestamp of the block where this transaction is included  #### Lightning Payment
/// * [comment] - Optional comment for this transaction
/// * [status] -  The status of the transaction. Depending on the transaction category this can be different values:  May have different meanings in different situations: #### unknown An unknown state was found.  #### in_flight * A lightning payment is being sent * An invoice is waiting for the incoming payment * An on-chain transaction is waiting in the mempool  #### succeeded * A lighting payment was successfully sent * An incoming payment was received for an invoice * An on-chain transaction was included in a block  #### failed * A lightning payment attempt which could not be completed (no route found, insufficient funds, ...) * An invoice is expired or some other error happened
/// * [blockHeight] - Block height, if included in a block. Only applicable for category **onchain**.
/// * [numConfs] - Number of confirmations. Only applicable for category **onchain**.
/// * [totalFees] - Total fees paid for this transaction
abstract class GenericTx implements Built<GenericTx, GenericTxBuilder> {
  /// The index of the transaction.
  @BuiltValueField(wireName: r'index')
  int? get index;

  ///  Unique identifier for this transaction.  Depending on the type of the transaction it will be different: #### On-chain The transaction hash  #### Lightning Invoice and Payment The payment request
  @BuiltValueField(wireName: r'id')
  String get id;

  /// Whether this is an onchain (**onchain**) or lightning (**ln**) transaction.
  @BuiltValueField(wireName: r'category')
  TxCategory? get category;

  /// Whether this is an outgoing (**send**) transaction or an incoming (**receive**) transaction.
  @BuiltValueField(wireName: r'type')
  TxType? get type;

  ///  The value of the transaction, depending on the category in satoshis or millisatoshis.  #### On-chain Transaction amount in satoshis  #### Lightning Invoice * value in millisatoshis of the invoice if *unsettled* * amount in millisatoshis paid if invoice is *settled*  #### Lightning Payment * amount sent in millisatoshis
  @BuiltValueField(wireName: r'amount')
  int get amount;

  ///  The unix timestamp in seconds for the transaction.  The timestamp can mean different things in different situations:  #### Lightning Invoice * Creation date for in-flight or failed invoices * Settle date for succeeded invoices  #### On-chain * Creation date for transaction waiting in the mempool * Timestamp of the block where this transaction is included  #### Lightning Payment
  @BuiltValueField(wireName: r'time_stamp')
  int get timeStamp;

  /// Optional comment for this transaction
  @BuiltValueField(wireName: r'comment')
  String? get comment;

  ///  The status of the transaction. Depending on the transaction category this can be different values:  May have different meanings in different situations: #### unknown An unknown state was found.  #### in_flight * A lightning payment is being sent * An invoice is waiting for the incoming payment * An on-chain transaction is waiting in the mempool  #### succeeded * A lighting payment was successfully sent * An incoming payment was received for an invoice * An on-chain transaction was included in a block  #### failed * A lightning payment attempt which could not be completed (no route found, insufficient funds, ...) * An invoice is expired or some other error happened
  @BuiltValueField(wireName: r'status')
  TxStatus? get status;

  /// Block height, if included in a block. Only applicable for category **onchain**.
  @BuiltValueField(wireName: r'block_height')
  int? get blockHeight;

  /// Number of confirmations. Only applicable for category **onchain**.
  @BuiltValueField(wireName: r'num_confs')
  int? get numConfs;

  /// Total fees paid for this transaction
  @BuiltValueField(wireName: r'total_fees')
  int? get totalFees;

  GenericTx._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GenericTxBuilder b) => b
    ..index = 0
    ..comment = '';

  factory GenericTx([void updates(GenericTxBuilder b)]) = _$GenericTx;

  @BuiltValueSerializer(custom: true)
  static Serializer<GenericTx> get serializer => _$GenericTxSerializer();
}

class _$GenericTxSerializer implements StructuredSerializer<GenericTx> {
  @override
  final Iterable<Type> types = const [GenericTx, _$GenericTx];

  @override
  final String wireName = r'GenericTx';

  @override
  Iterable<Object?> serialize(Serializers serializers, GenericTx object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    if (object.index != null) {
      result
        ..add(r'index')
        ..add(serializers.serialize(object.index,
            specifiedType: const FullType(int)));
    }
    result
      ..add(r'id')
      ..add(serializers.serialize(object.id,
          specifiedType: const FullType(String)));
    result
      ..add(r'category')
      ..add(object.category == null
          ? null
          : serializers.serialize(object.category,
              specifiedType: const FullType.nullable(TxCategory)));
    result
      ..add(r'type')
      ..add(object.type == null
          ? null
          : serializers.serialize(object.type,
              specifiedType: const FullType.nullable(TxType)));
    result
      ..add(r'amount')
      ..add(serializers.serialize(object.amount,
          specifiedType: const FullType(int)));
    result
      ..add(r'time_stamp')
      ..add(serializers.serialize(object.timeStamp,
          specifiedType: const FullType(int)));
    if (object.comment != null) {
      result
        ..add(r'comment')
        ..add(serializers.serialize(object.comment,
            specifiedType: const FullType(String)));
    }
    result
      ..add(r'status')
      ..add(object.status == null
          ? null
          : serializers.serialize(object.status,
              specifiedType: const FullType.nullable(TxStatus)));
    if (object.blockHeight != null) {
      result
        ..add(r'block_height')
        ..add(serializers.serialize(object.blockHeight,
            specifiedType: const FullType(int)));
    }
    if (object.numConfs != null) {
      result
        ..add(r'num_confs')
        ..add(serializers.serialize(object.numConfs,
            specifiedType: const FullType(int)));
    }
    if (object.totalFees != null) {
      result
        ..add(r'total_fees')
        ..add(serializers.serialize(object.totalFees,
            specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  GenericTx deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GenericTxBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;

      switch (key) {
        case r'index':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.index = valueDes;
          break;
        case r'id':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.id = valueDes;
          break;
        case r'category':
          final valueDes = serializers.deserialize(value,
                  specifiedType: const FullType.nullable(TxCategory))
              as TxCategory?;
          if (valueDes == null) continue;
          result.category = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType.nullable(TxType)) as TxType?;
          if (valueDes == null) continue;
          result.type = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.amount = valueDes;
          break;
        case r'time_stamp':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.timeStamp = valueDes;
          break;
        case r'comment':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.comment = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType.nullable(TxStatus)) as TxStatus?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        case r'block_height':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.blockHeight = valueDes;
          break;
        case r'num_confs':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.numConfs = valueDes;
          break;
        case r'total_fees':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.totalFees = valueDes;
          break;
      }
    }
    return result.build();
  }
}
