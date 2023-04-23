//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'payment_failure_reason.g.dart';

class PaymentFailureReason extends EnumClass {
  /// An enumeration.
  @BuiltValueEnumConst(wireName: r'FAILURE_REASON_NONE')
  static const PaymentFailureReason NONE = _$NONE;

  /// An enumeration.
  @BuiltValueEnumConst(wireName: r'FAILURE_REASON_TIMEOUT')
  static const PaymentFailureReason TIMEOUT = _$TIMEOUT;

  /// An enumeration.
  @BuiltValueEnumConst(wireName: r'FAILURE_REASON_NO_ROUTE')
  static const PaymentFailureReason NO_ROUTE = _$NO_ROUTE;

  /// An enumeration.
  @BuiltValueEnumConst(wireName: r'FAILURE_REASON_ERROR')
  static const PaymentFailureReason ERROR = _$ERROR;

  /// An enumeration.
  @BuiltValueEnumConst(wireName: r'FAILURE_REASON_INCORRECT_PAYMENT_DETAILS')
  static const PaymentFailureReason INCORRECT_PAYMENT_DETAILS =
      _$INCORRECT_PAYMENT_DETAILS;

  /// An enumeration.
  @BuiltValueEnumConst(wireName: r'FAILURE_REASON_INSUFFICIENT_BALANCE')
  static const PaymentFailureReason INSUFFICIENT_BALANCE =
      _$INSUFFICIENT_BALANCE;

  static Serializer<PaymentFailureReason> get serializer =>
      _$paymentFailureReasonSerializer;

  const PaymentFailureReason._(String name) : super(name);

  static BuiltSet<PaymentFailureReason> get values => _$values;
  static PaymentFailureReason valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class PaymentFailureReasonMixin = Object
    with _$PaymentFailureReasonMixin;
