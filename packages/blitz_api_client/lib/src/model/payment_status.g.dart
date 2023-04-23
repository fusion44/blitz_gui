// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PaymentStatus _$unknown = PaymentStatus._('unknown');
const PaymentStatus _$inFlight = PaymentStatus._('inFlight');
const PaymentStatus _$succeeded = PaymentStatus._('succeeded');
const PaymentStatus _$failed = PaymentStatus._('failed');

PaymentStatus _$valueOf(String name) {
  switch (name) {
    case 'unknown':
      return _$unknown;
    case 'inFlight':
      return _$inFlight;
    case 'succeeded':
      return _$succeeded;
    case 'failed':
      return _$failed;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<PaymentStatus> _$values =
    BuiltSet<PaymentStatus>(const <PaymentStatus>[
  _$unknown,
  _$inFlight,
  _$succeeded,
  _$failed,
]);

class _$PaymentStatusMeta {
  const _$PaymentStatusMeta();
  PaymentStatus get unknown => _$unknown;
  PaymentStatus get inFlight => _$inFlight;
  PaymentStatus get succeeded => _$succeeded;
  PaymentStatus get failed => _$failed;
  PaymentStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<PaymentStatus> get values => _$values;
}

abstract class _$PaymentStatusMixin {
  // ignore: non_constant_identifier_names
  _$PaymentStatusMeta get PaymentStatus => const _$PaymentStatusMeta();
}

Serializer<PaymentStatus> _$paymentStatusSerializer =
    _$PaymentStatusSerializer();

class _$PaymentStatusSerializer implements PrimitiveSerializer<PaymentStatus> {
  static const Map<String, Object> _toWire = <String, Object>{
    'unknown': 'unknown',
    'inFlight': 'in_flight',
    'succeeded': 'succeeded',
    'failed': 'failed',
  };
  static const Map<Object, String> _fromWire = <Object, String>{
    'unknown': 'unknown',
    'in_flight': 'inFlight',
    'succeeded': 'succeeded',
    'failed': 'failed',
  };

  @override
  final Iterable<Type> types = const <Type>[PaymentStatus];
  @override
  final String wireName = 'PaymentStatus';

  @override
  Object serialize(Serializers serializers, PaymentStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PaymentStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PaymentStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
