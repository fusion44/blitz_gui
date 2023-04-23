//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'invoice_htlc_state.g.dart';

class InvoiceHTLCState extends EnumClass {
  /// An enumeration.
  @BuiltValueEnumConst(wireName: r'accepted')
  static const InvoiceHTLCState accepted = _$accepted;

  /// An enumeration.
  @BuiltValueEnumConst(wireName: r'settled')
  static const InvoiceHTLCState settled = _$settled;

  /// An enumeration.
  @BuiltValueEnumConst(wireName: r'canceled')
  static const InvoiceHTLCState canceled = _$canceled;

  static Serializer<InvoiceHTLCState> get serializer =>
      _$invoiceHTLCStateSerializer;

  const InvoiceHTLCState._(String name) : super(name);

  static BuiltSet<InvoiceHTLCState> get values => _$values;
  static InvoiceHTLCState valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class InvoiceHTLCStateMixin = Object with _$InvoiceHTLCStateMixin;
