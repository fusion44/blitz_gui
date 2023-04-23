//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'tx_category.g.dart';

class TxCategory extends EnumClass {
  /// An enumeration.
  @BuiltValueEnumConst(wireName: r'onchain')
  static const TxCategory onchain = _$onchain;

  /// An enumeration.
  @BuiltValueEnumConst(wireName: r'ln')
  static const TxCategory ln = _$ln;

  static Serializer<TxCategory> get serializer => _$txCategorySerializer;

  const TxCategory._(String name) : super(name);

  static BuiltSet<TxCategory> get values => _$values;
  static TxCategory valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class TxCategoryMixin = Object with _$TxCategoryMixin;
