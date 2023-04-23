// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tx_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TxType _$unknown = TxType._('unknown');
const TxType _$send = TxType._('send');
const TxType _$receive = TxType._('receive');

TxType _$valueOf(String name) {
  switch (name) {
    case 'unknown':
      return _$unknown;
    case 'send':
      return _$send;
    case 'receive':
      return _$receive;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<TxType> _$values = BuiltSet<TxType>(const <TxType>[
  _$unknown,
  _$send,
  _$receive,
]);

class _$TxTypeMeta {
  const _$TxTypeMeta();
  TxType get unknown => _$unknown;
  TxType get send => _$send;
  TxType get receive => _$receive;
  TxType valueOf(String name) => _$valueOf(name);
  BuiltSet<TxType> get values => _$values;
}

abstract class _$TxTypeMixin {
  // ignore: non_constant_identifier_names
  _$TxTypeMeta get TxType => const _$TxTypeMeta();
}

Serializer<TxType> _$txTypeSerializer = _$TxTypeSerializer();

class _$TxTypeSerializer implements PrimitiveSerializer<TxType> {
  static const Map<String, Object> _toWire = <String, Object>{
    'unknown': 'unknown',
    'send': 'send',
    'receive': 'receive',
  };
  static const Map<Object, String> _fromWire = <Object, String>{
    'unknown': 'unknown',
    'send': 'send',
    'receive': 'receive',
  };

  @override
  final Iterable<Type> types = const <Type>[TxType];
  @override
  final String wireName = 'TxType';

  @override
  Object serialize(Serializers serializers, TxType object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  TxType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TxType.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
