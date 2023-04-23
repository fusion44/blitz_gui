//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'htlc_status.g.dart';

class HTLCStatus extends EnumClass {
  /// An enumeration.
  @BuiltValueEnumConst(wireName: r'in_flight')
  static const HTLCStatus inFlight = _$inFlight;

  /// An enumeration.
  @BuiltValueEnumConst(wireName: r'succeeded')
  static const HTLCStatus succeeded = _$succeeded;

  /// An enumeration.
  @BuiltValueEnumConst(wireName: r'failed')
  static const HTLCStatus failed = _$failed;

  static Serializer<HTLCStatus> get serializer => _$hTLCStatusSerializer;

  const HTLCStatus._(String name) : super(name);

  static BuiltSet<HTLCStatus> get values => _$values;
  static HTLCStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class HTLCStatusMixin = Object with _$HTLCStatusMixin;
