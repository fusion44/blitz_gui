// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onchain_address_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const OnchainAddressType _$p2wkh = OnchainAddressType._('p2wkh');
const OnchainAddressType _$np2wkh = OnchainAddressType._('np2wkh');

OnchainAddressType _$valueOf(String name) {
  switch (name) {
    case 'p2wkh':
      return _$p2wkh;
    case 'np2wkh':
      return _$np2wkh;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<OnchainAddressType> _$values =
    BuiltSet<OnchainAddressType>(const <OnchainAddressType>[
  _$p2wkh,
  _$np2wkh,
]);

class _$OnchainAddressTypeMeta {
  const _$OnchainAddressTypeMeta();
  OnchainAddressType get p2wkh => _$p2wkh;
  OnchainAddressType get np2wkh => _$np2wkh;
  OnchainAddressType valueOf(String name) => _$valueOf(name);
  BuiltSet<OnchainAddressType> get values => _$values;
}

abstract class _$OnchainAddressTypeMixin {
  // ignore: non_constant_identifier_names
  _$OnchainAddressTypeMeta get OnchainAddressType =>
      const _$OnchainAddressTypeMeta();
}

Serializer<OnchainAddressType> _$onchainAddressTypeSerializer =
    _$OnchainAddressTypeSerializer();

class _$OnchainAddressTypeSerializer
    implements PrimitiveSerializer<OnchainAddressType> {
  static const Map<String, Object> _toWire = <String, Object>{
    'p2wkh': 'p2wkh',
    'np2wkh': 'np2wkh',
  };
  static const Map<Object, String> _fromWire = <Object, String>{
    'p2wkh': 'p2wkh',
    'np2wkh': 'np2wkh',
  };

  @override
  final Iterable<Type> types = const <Type>[OnchainAddressType];
  @override
  final String wireName = 'OnchainAddressType';

  @override
  Object serialize(Serializers serializers, OnchainAddressType object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  OnchainAddressType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      OnchainAddressType.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
