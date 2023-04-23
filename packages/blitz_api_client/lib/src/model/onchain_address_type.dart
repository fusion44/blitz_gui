//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'onchain_address_type.g.dart';

class OnchainAddressType extends EnumClass {
  /// An enumeration.
  @BuiltValueEnumConst(wireName: r'p2wkh')
  static const OnchainAddressType p2wkh = _$p2wkh;

  /// An enumeration.
  @BuiltValueEnumConst(wireName: r'np2wkh')
  static const OnchainAddressType np2wkh = _$np2wkh;

  static Serializer<OnchainAddressType> get serializer =>
      _$onchainAddressTypeSerializer;

  const OnchainAddressType._(String name) : super(name);

  static BuiltSet<OnchainAddressType> get values => _$values;
  static OnchainAddressType valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class OnchainAddressTypeMixin = Object with _$OnchainAddressTypeMixin;
