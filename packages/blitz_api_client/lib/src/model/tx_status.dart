//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'tx_status.g.dart';

class TxStatus extends EnumClass {
  /// An enumeration.
  @BuiltValueEnumConst(wireName: r'unknown')
  static const TxStatus unknown = _$unknown;

  /// An enumeration.
  @BuiltValueEnumConst(wireName: r'in_flight')
  static const TxStatus inFlight = _$inFlight;

  /// An enumeration.
  @BuiltValueEnumConst(wireName: r'succeeded')
  static const TxStatus succeeded = _$succeeded;

  /// An enumeration.
  @BuiltValueEnumConst(wireName: r'failed')
  static const TxStatus failed = _$failed;

  static Serializer<TxStatus> get serializer => _$txStatusSerializer;

  const TxStatus._(String name) : super(name);

  static BuiltSet<TxStatus> get values => _$values;
  static TxStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class TxStatusMixin = Object with _$TxStatusMixin;
