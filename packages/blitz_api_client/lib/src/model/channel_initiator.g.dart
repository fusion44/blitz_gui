// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_initiator.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ChannelInitiator _$unknown = ChannelInitiator._('unknown');
const ChannelInitiator _$local = ChannelInitiator._('local');
const ChannelInitiator _$remote = ChannelInitiator._('remote');
const ChannelInitiator _$both = ChannelInitiator._('both');

ChannelInitiator _$valueOf(String name) {
  switch (name) {
    case 'unknown':
      return _$unknown;
    case 'local':
      return _$local;
    case 'remote':
      return _$remote;
    case 'both':
      return _$both;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ChannelInitiator> _$values =
    BuiltSet<ChannelInitiator>(const <ChannelInitiator>[
  _$unknown,
  _$local,
  _$remote,
  _$both,
]);

class _$ChannelInitiatorMeta {
  const _$ChannelInitiatorMeta();
  ChannelInitiator get unknown => _$unknown;
  ChannelInitiator get local => _$local;
  ChannelInitiator get remote => _$remote;
  ChannelInitiator get both => _$both;
  ChannelInitiator valueOf(String name) => _$valueOf(name);
  BuiltSet<ChannelInitiator> get values => _$values;
}

abstract class _$ChannelInitiatorMixin {
  // ignore: non_constant_identifier_names
  _$ChannelInitiatorMeta get ChannelInitiator => const _$ChannelInitiatorMeta();
}

Serializer<ChannelInitiator> _$channelInitiatorSerializer =
    _$ChannelInitiatorSerializer();

class _$ChannelInitiatorSerializer
    implements PrimitiveSerializer<ChannelInitiator> {
  static const Map<String, Object> _toWire = <String, Object>{
    'unknown': 'unknown',
    'local': 'local',
    'remote': 'remote',
    'both': 'both',
  };
  static const Map<Object, String> _fromWire = <Object, String>{
    'unknown': 'unknown',
    'local': 'local',
    'remote': 'remote',
    'both': 'both',
  };

  @override
  final Iterable<Type> types = const <Type>[ChannelInitiator];
  @override
  final String wireName = 'ChannelInitiator';

  @override
  Object serialize(Serializers serializers, ChannelInitiator object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ChannelInitiator deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ChannelInitiator.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
