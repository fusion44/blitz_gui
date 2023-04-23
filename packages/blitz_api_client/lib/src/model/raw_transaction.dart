//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';

part 'raw_transaction.g.dart';

/// RawTransaction
///
/// Properties:
/// * [inActiveChain] - Whether specified block is in the active chain or not (only present with explicit \"blockhash\" argument)
/// * [txid] - The transaction id (same as provided)
/// * [hash] - The transaction hash (differs from txid for witness transactions)
/// * [size] - The serialized transaction size
/// * [vsize] - The virtual transaction size (differs from size for witness transactions)
/// * [weight] - The transaction's weight (between vsize*4 - 3 and vsize*4)
/// * [version] - The version
/// * [locktime] - The lock time
/// * [vin] - The transaction's inputs
/// * [vout] - The transaction's outputs
/// * [blockhash] - The block hash
/// * [confirmations] - The number of confirmations
/// * [blocktime] - The block time in seconds since epoch (Jan 1 1970 GMT)
abstract class RawTransaction
    implements Built<RawTransaction, RawTransactionBuilder> {
  /// Whether specified block is in the active chain or not (only present with explicit \"blockhash\" argument)
  @BuiltValueField(wireName: r'in_active_chain')
  bool? get inActiveChain;

  /// The transaction id (same as provided)
  @BuiltValueField(wireName: r'txid')
  String get txid;

  /// The transaction hash (differs from txid for witness transactions)
  @BuiltValueField(wireName: r'hash')
  String get hash;

  /// The serialized transaction size
  @BuiltValueField(wireName: r'size')
  int get size;

  /// The virtual transaction size (differs from size for witness transactions)
  @BuiltValueField(wireName: r'vsize')
  int get vsize;

  /// The transaction's weight (between vsize*4 - 3 and vsize*4)
  @BuiltValueField(wireName: r'weight')
  int get weight;

  /// The version
  @BuiltValueField(wireName: r'version')
  int get version;

  /// The lock time
  @BuiltValueField(wireName: r'locktime')
  int get locktime;

  /// The transaction's inputs
  @BuiltValueField(wireName: r'vin')
  BuiltList<JsonObject> get vin;

  /// The transaction's outputs
  @BuiltValueField(wireName: r'vout')
  BuiltList<JsonObject> get vout;

  /// The block hash
  @BuiltValueField(wireName: r'blockhash')
  String get blockhash;

  /// The number of confirmations
  @BuiltValueField(wireName: r'confirmations')
  int get confirmations;

  /// The block time in seconds since epoch (Jan 1 1970 GMT)
  @BuiltValueField(wireName: r'blocktime')
  int get blocktime;

  RawTransaction._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RawTransactionBuilder b) => b;

  factory RawTransaction([void updates(RawTransactionBuilder b)]) =
      _$RawTransaction;

  @BuiltValueSerializer(custom: true)
  static Serializer<RawTransaction> get serializer =>
      _$RawTransactionSerializer();
}

class _$RawTransactionSerializer
    implements StructuredSerializer<RawTransaction> {
  @override
  final Iterable<Type> types = const [RawTransaction, _$RawTransaction];

  @override
  final String wireName = r'RawTransaction';

  @override
  Iterable<Object?> serialize(Serializers serializers, RawTransaction object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    if (object.inActiveChain != null) {
      result
        ..add(r'in_active_chain')
        ..add(serializers.serialize(object.inActiveChain,
            specifiedType: const FullType(bool)));
    }
    result
      ..add(r'txid')
      ..add(serializers.serialize(object.txid,
          specifiedType: const FullType(String)));
    result
      ..add(r'hash')
      ..add(serializers.serialize(object.hash,
          specifiedType: const FullType(String)));
    result
      ..add(r'size')
      ..add(serializers.serialize(object.size,
          specifiedType: const FullType(int)));
    result
      ..add(r'vsize')
      ..add(serializers.serialize(object.vsize,
          specifiedType: const FullType(int)));
    result
      ..add(r'weight')
      ..add(serializers.serialize(object.weight,
          specifiedType: const FullType(int)));
    result
      ..add(r'version')
      ..add(serializers.serialize(object.version,
          specifiedType: const FullType(int)));
    result
      ..add(r'locktime')
      ..add(serializers.serialize(object.locktime,
          specifiedType: const FullType(int)));
    result
      ..add(r'vin')
      ..add(serializers.serialize(object.vin,
          specifiedType: const FullType(BuiltList, [FullType(JsonObject)])));
    result
      ..add(r'vout')
      ..add(serializers.serialize(object.vout,
          specifiedType: const FullType(BuiltList, [FullType(JsonObject)])));
    result
      ..add(r'blockhash')
      ..add(serializers.serialize(object.blockhash,
          specifiedType: const FullType(String)));
    result
      ..add(r'confirmations')
      ..add(serializers.serialize(object.confirmations,
          specifiedType: const FullType(int)));
    result
      ..add(r'blocktime')
      ..add(serializers.serialize(object.blocktime,
          specifiedType: const FullType(int)));
    return result;
  }

  @override
  RawTransaction deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = RawTransactionBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;

      switch (key) {
        case r'in_active_chain':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          result.inActiveChain = valueDes;
          break;
        case r'txid':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.txid = valueDes;
          break;
        case r'hash':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.hash = valueDes;
          break;
        case r'size':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.size = valueDes;
          break;
        case r'vsize':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.vsize = valueDes;
          break;
        case r'weight':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.weight = valueDes;
          break;
        case r'version':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.version = valueDes;
          break;
        case r'locktime':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.locktime = valueDes;
          break;
        case r'vin':
          final valueDes = serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, [FullType(JsonObject)]))
              as BuiltList<JsonObject>;
          result.vin.replace(valueDes);
          break;
        case r'vout':
          final valueDes = serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, [FullType(JsonObject)]))
              as BuiltList<JsonObject>;
          result.vout.replace(valueDes);
          break;
        case r'blockhash':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.blockhash = valueDes;
          break;
        case r'confirmations':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.confirmations = valueDes;
          break;
        case r'blocktime':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.blocktime = valueDes;
          break;
      }
    }
    return result.build();
  }
}
