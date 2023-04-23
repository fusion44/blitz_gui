//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'invoice_state.g.dart';

class InvoiceState extends EnumClass {
  /// An enumeration.
  @BuiltValueEnumConst(wireName: r'open')
  static const InvoiceState open = _$open;

  /// An enumeration.
  @BuiltValueEnumConst(wireName: r'settled')
  static const InvoiceState settled = _$settled;

  /// An enumeration.
  @BuiltValueEnumConst(wireName: r'canceled')
  static const InvoiceState canceled = _$canceled;

  /// An enumeration.
  @BuiltValueEnumConst(wireName: r'accepted')
  static const InvoiceState accepted = _$accepted;

  static Serializer<InvoiceState> get serializer => _$invoiceStateSerializer;

  const InvoiceState._(String name) : super(name);

  static BuiltSet<InvoiceState> get values => _$values;
  static InvoiceState valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class InvoiceStateMixin = Object with _$InvoiceStateMixin;
