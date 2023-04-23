// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_failure_reason.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PaymentFailureReason _$NONE = PaymentFailureReason._('NONE');
const PaymentFailureReason _$TIMEOUT = PaymentFailureReason._('TIMEOUT');
const PaymentFailureReason _$NO_ROUTE = PaymentFailureReason._('NO_ROUTE');
const PaymentFailureReason _$ERROR = PaymentFailureReason._('ERROR');
const PaymentFailureReason _$INCORRECT_PAYMENT_DETAILS =
    PaymentFailureReason._('INCORRECT_PAYMENT_DETAILS');
const PaymentFailureReason _$INSUFFICIENT_BALANCE =
    PaymentFailureReason._('INSUFFICIENT_BALANCE');

PaymentFailureReason _$valueOf(String name) {
  switch (name) {
    case 'NONE':
      return _$NONE;
    case 'TIMEOUT':
      return _$TIMEOUT;
    case 'NO_ROUTE':
      return _$NO_ROUTE;
    case 'ERROR':
      return _$ERROR;
    case 'INCORRECT_PAYMENT_DETAILS':
      return _$INCORRECT_PAYMENT_DETAILS;
    case 'INSUFFICIENT_BALANCE':
      return _$INSUFFICIENT_BALANCE;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<PaymentFailureReason> _$values =
    BuiltSet<PaymentFailureReason>(const <PaymentFailureReason>[
  _$NONE,
  _$TIMEOUT,
  _$NO_ROUTE,
  _$ERROR,
  _$INCORRECT_PAYMENT_DETAILS,
  _$INSUFFICIENT_BALANCE,
]);

class _$PaymentFailureReasonMeta {
  const _$PaymentFailureReasonMeta();
  PaymentFailureReason get NONE => _$NONE;
  PaymentFailureReason get TIMEOUT => _$TIMEOUT;
  PaymentFailureReason get NO_ROUTE => _$NO_ROUTE;
  PaymentFailureReason get ERROR => _$ERROR;
  PaymentFailureReason get INCORRECT_PAYMENT_DETAILS =>
      _$INCORRECT_PAYMENT_DETAILS;
  PaymentFailureReason get INSUFFICIENT_BALANCE => _$INSUFFICIENT_BALANCE;
  PaymentFailureReason valueOf(String name) => _$valueOf(name);
  BuiltSet<PaymentFailureReason> get values => _$values;
}

abstract class _$PaymentFailureReasonMixin {
  // ignore: non_constant_identifier_names
  _$PaymentFailureReasonMeta get PaymentFailureReason =>
      const _$PaymentFailureReasonMeta();
}

Serializer<PaymentFailureReason> _$paymentFailureReasonSerializer =
    _$PaymentFailureReasonSerializer();

class _$PaymentFailureReasonSerializer
    implements PrimitiveSerializer<PaymentFailureReason> {
  static const Map<String, Object> _toWire = <String, Object>{
    'NONE': 'FAILURE_REASON_NONE',
    'TIMEOUT': 'FAILURE_REASON_TIMEOUT',
    'NO_ROUTE': 'FAILURE_REASON_NO_ROUTE',
    'ERROR': 'FAILURE_REASON_ERROR',
    'INCORRECT_PAYMENT_DETAILS': 'FAILURE_REASON_INCORRECT_PAYMENT_DETAILS',
    'INSUFFICIENT_BALANCE': 'FAILURE_REASON_INSUFFICIENT_BALANCE',
  };
  static const Map<Object, String> _fromWire = <Object, String>{
    'FAILURE_REASON_NONE': 'NONE',
    'FAILURE_REASON_TIMEOUT': 'TIMEOUT',
    'FAILURE_REASON_NO_ROUTE': 'NO_ROUTE',
    'FAILURE_REASON_ERROR': 'ERROR',
    'FAILURE_REASON_INCORRECT_PAYMENT_DETAILS': 'INCORRECT_PAYMENT_DETAILS',
    'FAILURE_REASON_INSUFFICIENT_BALANCE': 'INSUFFICIENT_BALANCE',
  };

  @override
  final Iterable<Type> types = const <Type>[PaymentFailureReason];
  @override
  final String wireName = 'PaymentFailureReason';

  @override
  Object serialize(Serializers serializers, PaymentFailureReason object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PaymentFailureReason deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PaymentFailureReason.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
