// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fee_estimation_mode.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FeeEstimationMode _$conservative = FeeEstimationMode._('conservative');
const FeeEstimationMode _$economical = FeeEstimationMode._('economical');

FeeEstimationMode _$valueOf(String name) {
  switch (name) {
    case 'conservative':
      return _$conservative;
    case 'economical':
      return _$economical;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FeeEstimationMode> _$values =
    BuiltSet<FeeEstimationMode>(const <FeeEstimationMode>[
  _$conservative,
  _$economical,
]);

class _$FeeEstimationModeMeta {
  const _$FeeEstimationModeMeta();
  FeeEstimationMode get conservative => _$conservative;
  FeeEstimationMode get economical => _$economical;
  FeeEstimationMode valueOf(String name) => _$valueOf(name);
  BuiltSet<FeeEstimationMode> get values => _$values;
}

abstract class _$FeeEstimationModeMixin {
  // ignore: non_constant_identifier_names
  _$FeeEstimationModeMeta get FeeEstimationMode =>
      const _$FeeEstimationModeMeta();
}

Serializer<FeeEstimationMode> _$feeEstimationModeSerializer =
    _$FeeEstimationModeSerializer();

class _$FeeEstimationModeSerializer
    implements PrimitiveSerializer<FeeEstimationMode> {
  static const Map<String, Object> _toWire = <String, Object>{
    'conservative': 'conservative',
    'economical': 'economical',
  };
  static const Map<Object, String> _fromWire = <Object, String>{
    'conservative': 'conservative',
    'economical': 'economical',
  };

  @override
  final Iterable<Type> types = const <Type>[FeeEstimationMode];
  @override
  final String wireName = 'FeeEstimationMode';

  @override
  Object serialize(Serializers serializers, FeeEstimationMode object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FeeEstimationMode deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FeeEstimationMode.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
