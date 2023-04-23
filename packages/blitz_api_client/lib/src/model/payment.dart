//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:blitz_api_client/src/model/htlc_attempt.dart';
import 'package:blitz_api_client/src/model/payment_failure_reason.dart';
import 'package:blitz_api_client/src/model/payment_status.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'payment.g.dart';

/// Payment
///
/// Properties:
/// * [paymentHash] - The payment hash
/// * [paymentPreimage] - The payment preimage
/// * [valueMsat] - The value of the payment in milli-satoshis
/// * [paymentRequest] - The optional payment request being fulfilled.
/// * [status] - The status of the payment.
/// * [feeMsat] - The fee paid for this payment in msat
/// * [creationTimeNs] - The time in UNIX nanoseconds at which the payment was created.
/// * [htlcs] - The HTLCs made in attempt to settle the payment.
/// * [paymentIndex] - The payment index. Only set with LND, 0 otherwise.
/// * [label] - The payment label. Only set with CLN, empty otherwise.
/// * [failureReason] - The failure reason
abstract class Payment implements Built<Payment, PaymentBuilder> {
  /// The payment hash
  @BuiltValueField(wireName: r'payment_hash')
  String get paymentHash;

  /// The payment preimage
  @BuiltValueField(wireName: r'payment_preimage')
  String? get paymentPreimage;

  /// The value of the payment in milli-satoshis
  @BuiltValueField(wireName: r'value_msat')
  int get valueMsat;

  /// The optional payment request being fulfilled.
  @BuiltValueField(wireName: r'payment_request')
  String? get paymentRequest;

  /// The status of the payment.
  @BuiltValueField(wireName: r'status')
  PaymentStatus? get status;

  /// The fee paid for this payment in msat
  @BuiltValueField(wireName: r'fee_msat')
  int get feeMsat;

  /// The time in UNIX nanoseconds at which the payment was created.
  @BuiltValueField(wireName: r'creation_time_ns')
  int get creationTimeNs;

  /// The HTLCs made in attempt to settle the payment.
  @BuiltValueField(wireName: r'htlcs')
  BuiltList<HTLCAttempt>? get htlcs;

  /// The payment index. Only set with LND, 0 otherwise.
  @BuiltValueField(wireName: r'payment_index')
  int? get paymentIndex;

  /// The payment label. Only set with CLN, empty otherwise.
  @BuiltValueField(wireName: r'label')
  String? get label;

  /// The failure reason
  @BuiltValueField(wireName: r'failure_reason')
  PaymentFailureReason? get failureReason;

  Payment._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PaymentBuilder b) => b
    ..htlcs = ListBuilder()
    ..paymentIndex = 0
    ..label = '';

  factory Payment([void updates(PaymentBuilder b)]) = _$Payment;

  @BuiltValueSerializer(custom: true)
  static Serializer<Payment> get serializer => _$PaymentSerializer();
}

class _$PaymentSerializer implements StructuredSerializer<Payment> {
  @override
  final Iterable<Type> types = const [Payment, _$Payment];

  @override
  final String wireName = r'Payment';

  @override
  Iterable<Object?> serialize(Serializers serializers, Payment object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    result
      ..add(r'payment_hash')
      ..add(serializers.serialize(object.paymentHash,
          specifiedType: const FullType(String)));
    if (object.paymentPreimage != null) {
      result
        ..add(r'payment_preimage')
        ..add(serializers.serialize(object.paymentPreimage,
            specifiedType: const FullType(String)));
    }
    result
      ..add(r'value_msat')
      ..add(serializers.serialize(object.valueMsat,
          specifiedType: const FullType(int)));
    if (object.paymentRequest != null) {
      result
        ..add(r'payment_request')
        ..add(serializers.serialize(object.paymentRequest,
            specifiedType: const FullType(String)));
    }
    if (object.status != null) {
      result
        ..add(r'status')
        ..add(serializers.serialize(object.status,
            specifiedType: const FullType.nullable(PaymentStatus)));
    }
    result
      ..add(r'fee_msat')
      ..add(serializers.serialize(object.feeMsat,
          specifiedType: const FullType(int)));
    result
      ..add(r'creation_time_ns')
      ..add(serializers.serialize(object.creationTimeNs,
          specifiedType: const FullType(int)));
    if (object.htlcs != null) {
      result
        ..add(r'htlcs')
        ..add(serializers.serialize(object.htlcs,
            specifiedType: const FullType(BuiltList, [FullType(HTLCAttempt)])));
    }
    if (object.paymentIndex != null) {
      result
        ..add(r'payment_index')
        ..add(serializers.serialize(object.paymentIndex,
            specifiedType: const FullType(int)));
    }
    if (object.label != null) {
      result
        ..add(r'label')
        ..add(serializers.serialize(object.label,
            specifiedType: const FullType(String)));
    }
    if (object.failureReason != null) {
      result
        ..add(r'failure_reason')
        ..add(serializers.serialize(object.failureReason,
            specifiedType: const FullType.nullable(PaymentFailureReason)));
    }
    return result;
  }

  @override
  Payment deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = PaymentBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;

      switch (key) {
        case r'payment_hash':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.paymentHash = valueDes;
          break;
        case r'payment_preimage':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.paymentPreimage = valueDes;
          break;
        case r'value_msat':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.valueMsat = valueDes;
          break;
        case r'payment_request':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.paymentRequest = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(value,
                  specifiedType: const FullType.nullable(PaymentStatus))
              as PaymentStatus?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        case r'fee_msat':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.feeMsat = valueDes;
          break;
        case r'creation_time_ns':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.creationTimeNs = valueDes;
          break;
        case r'htlcs':
          final valueDes = serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, [FullType(HTLCAttempt)]))
              as BuiltList<HTLCAttempt>;
          result.htlcs.replace(valueDes);
          break;
        case r'payment_index':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.paymentIndex = valueDes;
          break;
        case r'label':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.label = valueDes;
          break;
        case r'failure_reason':
          final valueDes = serializers.deserialize(value,
                  specifiedType: const FullType.nullable(PaymentFailureReason))
              as PaymentFailureReason?;
          if (valueDes == null) continue;
          result.failureReason = valueDes;
          break;
      }
    }
    return result.build();
  }
}
