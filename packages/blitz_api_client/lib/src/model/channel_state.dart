//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'channel_state.g.dart';

class ChannelState extends EnumClass {
  /// An enumeration.
  @BuiltValueEnumConst(wireName: r'opening')
  static const ChannelState opening = _$opening;

  /// An enumeration.
  @BuiltValueEnumConst(wireName: r'normal')
  static const ChannelState normal = _$normal;

  /// An enumeration.
  @BuiltValueEnumConst(wireName: r'closing')
  static const ChannelState closing = _$closing;

  /// An enumeration.
  @BuiltValueEnumConst(wireName: r'force_closing')
  static const ChannelState forceClosing = _$forceClosing;

  /// An enumeration.
  @BuiltValueEnumConst(wireName: r'closed')
  static const ChannelState closed = _$closed;

  /// An enumeration.
  @BuiltValueEnumConst(wireName: r'abandoned')
  static const ChannelState abandoned = _$abandoned;

  /// An enumeration.
  @BuiltValueEnumConst(wireName: r'unknown')
  static const ChannelState unknown = _$unknown;

  static Serializer<ChannelState> get serializer => _$channelStateSerializer;

  const ChannelState._(String name) : super(name);

  static BuiltSet<ChannelState> get values => _$values;
  static ChannelState valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class ChannelStateMixin = Object with _$ChannelStateMixin;
