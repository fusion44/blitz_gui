// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const InvoiceState _$open = InvoiceState._('open');
const InvoiceState _$settled = InvoiceState._('settled');
const InvoiceState _$canceled = InvoiceState._('canceled');
const InvoiceState _$accepted = InvoiceState._('accepted');

InvoiceState _$valueOf(String name) {
  switch (name) {
    case 'open':
      return _$open;
    case 'settled':
      return _$settled;
    case 'canceled':
      return _$canceled;
    case 'accepted':
      return _$accepted;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<InvoiceState> _$values =
    BuiltSet<InvoiceState>(const <InvoiceState>[
  _$open,
  _$settled,
  _$canceled,
  _$accepted,
]);

class _$InvoiceStateMeta {
  const _$InvoiceStateMeta();
  InvoiceState get open => _$open;
  InvoiceState get settled => _$settled;
  InvoiceState get canceled => _$canceled;
  InvoiceState get accepted => _$accepted;
  InvoiceState valueOf(String name) => _$valueOf(name);
  BuiltSet<InvoiceState> get values => _$values;
}

abstract class _$InvoiceStateMixin {
  // ignore: non_constant_identifier_names
  _$InvoiceStateMeta get InvoiceState => const _$InvoiceStateMeta();
}

Serializer<InvoiceState> _$invoiceStateSerializer = _$InvoiceStateSerializer();

class _$InvoiceStateSerializer implements PrimitiveSerializer<InvoiceState> {
  static const Map<String, Object> _toWire = <String, Object>{
    'open': 'open',
    'settled': 'settled',
    'canceled': 'canceled',
    'accepted': 'accepted',
  };
  static const Map<Object, String> _fromWire = <Object, String>{
    'open': 'open',
    'settled': 'settled',
    'canceled': 'canceled',
    'accepted': 'accepted',
  };

  @override
  final Iterable<Type> types = const <Type>[InvoiceState];
  @override
  final String wireName = 'InvoiceState';

  @override
  Object serialize(Serializers serializers, InvoiceState object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  InvoiceState deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      InvoiceState.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
