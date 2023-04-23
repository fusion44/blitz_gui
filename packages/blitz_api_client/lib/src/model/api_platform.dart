//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'api_platform.g.dart';

class APIPlatform extends EnumClass {
  /// An enumeration.
  @BuiltValueEnumConst(wireName: r'raspiblitz')
  static const APIPlatform raspiblitz = _$raspiblitz;

  /// An enumeration.
  @BuiltValueEnumConst(wireName: r'native_python')
  static const APIPlatform nativePython = _$nativePython;

  /// An enumeration.
  @BuiltValueEnumConst(wireName: r'unknown')
  static const APIPlatform unknown = _$unknown;

  static Serializer<APIPlatform> get serializer => _$aPIPlatformSerializer;

  const APIPlatform._(String name) : super(name);

  static BuiltSet<APIPlatform> get values => _$values;
  static APIPlatform valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class APIPlatformMixin = Object with _$APIPlatformMixin;
