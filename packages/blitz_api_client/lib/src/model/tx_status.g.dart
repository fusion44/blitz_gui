// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tx_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TxStatus _$unknown = TxStatus._('unknown');
const TxStatus _$inFlight = TxStatus._('inFlight');
const TxStatus _$succeeded = TxStatus._('succeeded');
const TxStatus _$failed = TxStatus._('failed');

TxStatus _$valueOf(String name) {
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

final BuiltSet<TxStatus> _$values = BuiltSet<TxStatus>(const <TxStatus>[
  _$unknown,
  _$inFlight,
  _$succeeded,
  _$failed,
]);

class _$TxStatusMeta {
  const _$TxStatusMeta();
  TxStatus get unknown => _$unknown;
  TxStatus get inFlight => _$inFlight;
  TxStatus get succeeded => _$succeeded;
  TxStatus get failed => _$failed;
  TxStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<TxStatus> get values => _$values;
}

abstract class _$TxStatusMixin {
  // ignore: non_constant_identifier_names
  _$TxStatusMeta get TxStatus => const _$TxStatusMeta();
}

Serializer<TxStatus> _$txStatusSerializer = _$TxStatusSerializer();

class _$TxStatusSerializer implements PrimitiveSerializer<TxStatus> {
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
  final Iterable<Type> types = const <Type>[TxStatus];
  @override
  final String wireName = 'TxStatus';

  @override
  Object serialize(Serializers serializers, TxStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  TxStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TxStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
