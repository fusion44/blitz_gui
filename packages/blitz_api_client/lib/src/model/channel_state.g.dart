// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ChannelState _$opening = ChannelState._('opening');
const ChannelState _$normal = ChannelState._('normal');
const ChannelState _$closing = ChannelState._('closing');
const ChannelState _$forceClosing = ChannelState._('forceClosing');
const ChannelState _$closed = ChannelState._('closed');
const ChannelState _$abandoned = ChannelState._('abandoned');
const ChannelState _$unknown = ChannelState._('unknown');

ChannelState _$valueOf(String name) {
  switch (name) {
    case 'opening':
      return _$opening;
    case 'normal':
      return _$normal;
    case 'closing':
      return _$closing;
    case 'forceClosing':
      return _$forceClosing;
    case 'closed':
      return _$closed;
    case 'abandoned':
      return _$abandoned;
    case 'unknown':
      return _$unknown;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ChannelState> _$values =
    BuiltSet<ChannelState>(const <ChannelState>[
  _$opening,
  _$normal,
  _$closing,
  _$forceClosing,
  _$closed,
  _$abandoned,
  _$unknown,
]);

class _$ChannelStateMeta {
  const _$ChannelStateMeta();
  ChannelState get opening => _$opening;
  ChannelState get normal => _$normal;
  ChannelState get closing => _$closing;
  ChannelState get forceClosing => _$forceClosing;
  ChannelState get closed => _$closed;
  ChannelState get abandoned => _$abandoned;
  ChannelState get unknown => _$unknown;
  ChannelState valueOf(String name) => _$valueOf(name);
  BuiltSet<ChannelState> get values => _$values;
}

abstract class _$ChannelStateMixin {
  // ignore: non_constant_identifier_names
  _$ChannelStateMeta get ChannelState => const _$ChannelStateMeta();
}

Serializer<ChannelState> _$channelStateSerializer = _$ChannelStateSerializer();

class _$ChannelStateSerializer implements PrimitiveSerializer<ChannelState> {
  static const Map<String, Object> _toWire = <String, Object>{
    'opening': 'opening',
    'normal': 'normal',
    'closing': 'closing',
    'forceClosing': 'force_closing',
    'closed': 'closed',
    'abandoned': 'abandoned',
    'unknown': 'unknown',
  };
  static const Map<Object, String> _fromWire = <Object, String>{
    'opening': 'opening',
    'normal': 'normal',
    'closing': 'closing',
    'force_closing': 'forceClosing',
    'closed': 'closed',
    'abandoned': 'abandoned',
    'unknown': 'unknown',
  };

  @override
  final Iterable<Type> types = const <Type>[ChannelState];
  @override
  final String wireName = 'ChannelState';

  @override
  Object serialize(Serializers serializers, ChannelState object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ChannelState deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ChannelState.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
