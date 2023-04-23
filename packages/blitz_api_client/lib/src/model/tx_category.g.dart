// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tx_category.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TxCategory _$onchain = TxCategory._('onchain');
const TxCategory _$ln = TxCategory._('ln');

TxCategory _$valueOf(String name) {
  switch (name) {
    case 'onchain':
      return _$onchain;
    case 'ln':
      return _$ln;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<TxCategory> _$values = BuiltSet<TxCategory>(const <TxCategory>[
  _$onchain,
  _$ln,
]);

class _$TxCategoryMeta {
  const _$TxCategoryMeta();
  TxCategory get onchain => _$onchain;
  TxCategory get ln => _$ln;
  TxCategory valueOf(String name) => _$valueOf(name);
  BuiltSet<TxCategory> get values => _$values;
}

abstract class _$TxCategoryMixin {
  // ignore: non_constant_identifier_names
  _$TxCategoryMeta get TxCategory => const _$TxCategoryMeta();
}

Serializer<TxCategory> _$txCategorySerializer = _$TxCategorySerializer();

class _$TxCategorySerializer implements PrimitiveSerializer<TxCategory> {
  static const Map<String, Object> _toWire = <String, Object>{
    'onchain': 'onchain',
    'ln': 'ln',
  };
  static const Map<Object, String> _fromWire = <Object, String>{
    'onchain': 'onchain',
    'ln': 'ln',
  };

  @override
  final Iterable<Type> types = const <Type>[TxCategory];
  @override
  final String wireName = 'TxCategory';

  @override
  Object serialize(Serializers serializers, TxCategory object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  TxCategory deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TxCategory.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
