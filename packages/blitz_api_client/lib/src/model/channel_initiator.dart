//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'channel_initiator.g.dart';

class ChannelInitiator extends EnumClass {
  /// An enumeration.
  @BuiltValueEnumConst(wireName: r'unknown')
  static const ChannelInitiator unknown = _$unknown;

  /// An enumeration.
  @BuiltValueEnumConst(wireName: r'local')
  static const ChannelInitiator local = _$local;

  /// An enumeration.
  @BuiltValueEnumConst(wireName: r'remote')
  static const ChannelInitiator remote = _$remote;

  /// An enumeration.
  @BuiltValueEnumConst(wireName: r'both')
  static const ChannelInitiator both = _$both;

  static Serializer<ChannelInitiator> get serializer =>
      _$channelInitiatorSerializer;

  const ChannelInitiator._(String name) : super(name);

  static BuiltSet<ChannelInitiator> get values => _$values;
  static ChannelInitiator valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class ChannelInitiatorMixin = Object with _$ChannelInitiatorMixin;
