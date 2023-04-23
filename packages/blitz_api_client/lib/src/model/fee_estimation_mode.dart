//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'fee_estimation_mode.g.dart';

class FeeEstimationMode extends EnumClass {
  /// An enumeration.
  @BuiltValueEnumConst(wireName: r'conservative')
  static const FeeEstimationMode conservative = _$conservative;

  /// An enumeration.
  @BuiltValueEnumConst(wireName: r'economical')
  static const FeeEstimationMode economical = _$economical;

  static Serializer<FeeEstimationMode> get serializer =>
      _$feeEstimationModeSerializer;

  const FeeEstimationMode._(String name) : super(name);

  static BuiltSet<FeeEstimationMode> get values => _$values;
  static FeeEstimationMode valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class FeeEstimationModeMixin = Object with _$FeeEstimationModeMixin;
