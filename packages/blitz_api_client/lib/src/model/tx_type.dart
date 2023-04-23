//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'tx_type.g.dart';

class TxType extends EnumClass {
  /// An enumeration.
  @BuiltValueEnumConst(wireName: r'unknown')
  static const TxType unknown = _$unknown;

  /// An enumeration.
  @BuiltValueEnumConst(wireName: r'send')
  static const TxType send = _$send;

  /// An enumeration.
  @BuiltValueEnumConst(wireName: r'receive')
  static const TxType receive = _$receive;

  static Serializer<TxType> get serializer => _$txTypeSerializer;

  const TxType._(String name) : super(name);

  static BuiltSet<TxType> get values => _$values;
  static TxType valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class TxTypeMixin = Object with _$TxTypeMixin;
