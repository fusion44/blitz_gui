// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'htlc_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HTLCStatus _$inFlight = HTLCStatus._('inFlight');
const HTLCStatus _$succeeded = HTLCStatus._('succeeded');
const HTLCStatus _$failed = HTLCStatus._('failed');

HTLCStatus _$valueOf(String name) {
  switch (name) {
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

final BuiltSet<HTLCStatus> _$values = BuiltSet<HTLCStatus>(const <HTLCStatus>[
  _$inFlight,
  _$succeeded,
  _$failed,
]);

class _$HTLCStatusMeta {
  const _$HTLCStatusMeta();
  HTLCStatus get inFlight => _$inFlight;
  HTLCStatus get succeeded => _$succeeded;
  HTLCStatus get failed => _$failed;
  HTLCStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<HTLCStatus> get values => _$values;
}

abstract class _$HTLCStatusMixin {
  // ignore: non_constant_identifier_names
  _$HTLCStatusMeta get HTLCStatus => const _$HTLCStatusMeta();
}

Serializer<HTLCStatus> _$hTLCStatusSerializer = _$HTLCStatusSerializer();

class _$HTLCStatusSerializer implements PrimitiveSerializer<HTLCStatus> {
  static const Map<String, Object> _toWire = <String, Object>{
    'inFlight': 'in_flight',
    'succeeded': 'succeeded',
    'failed': 'failed',
  };
  static const Map<Object, String> _fromWire = <Object, String>{
    'in_flight': 'inFlight',
    'succeeded': 'succeeded',
    'failed': 'failed',
  };

  @override
  final Iterable<Type> types = const <Type>[HTLCStatus];
  @override
  final String wireName = 'HTLCStatus';

  @override
  Object serialize(Serializers serializers, HTLCStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  HTLCStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      HTLCStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
