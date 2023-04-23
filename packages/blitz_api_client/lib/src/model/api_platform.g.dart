// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_platform.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const APIPlatform _$raspiblitz = APIPlatform._('raspiblitz');
const APIPlatform _$nativePython = APIPlatform._('nativePython');
const APIPlatform _$unknown = APIPlatform._('unknown');

APIPlatform _$valueOf(String name) {
  switch (name) {
    case 'raspiblitz':
      return _$raspiblitz;
    case 'nativePython':
      return _$nativePython;
    case 'unknown':
      return _$unknown;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<APIPlatform> _$values =
    BuiltSet<APIPlatform>(const <APIPlatform>[
  _$raspiblitz,
  _$nativePython,
  _$unknown,
]);

class _$APIPlatformMeta {
  const _$APIPlatformMeta();
  APIPlatform get raspiblitz => _$raspiblitz;
  APIPlatform get nativePython => _$nativePython;
  APIPlatform get unknown => _$unknown;
  APIPlatform valueOf(String name) => _$valueOf(name);
  BuiltSet<APIPlatform> get values => _$values;
}

abstract class _$APIPlatformMixin {
  // ignore: non_constant_identifier_names
  _$APIPlatformMeta get APIPlatform => const _$APIPlatformMeta();
}

Serializer<APIPlatform> _$aPIPlatformSerializer = _$APIPlatformSerializer();

class _$APIPlatformSerializer implements PrimitiveSerializer<APIPlatform> {
  static const Map<String, Object> _toWire = <String, Object>{
    'raspiblitz': 'raspiblitz',
    'nativePython': 'native_python',
    'unknown': 'unknown',
  };
  static const Map<Object, String> _fromWire = <Object, String>{
    'raspiblitz': 'raspiblitz',
    'native_python': 'nativePython',
    'unknown': 'unknown',
  };

  @override
  final Iterable<Type> types = const <Type>[APIPlatform];
  @override
  final String wireName = 'APIPlatform';

  @override
  Object serialize(Serializers serializers, APIPlatform object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  APIPlatform deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      APIPlatform.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
