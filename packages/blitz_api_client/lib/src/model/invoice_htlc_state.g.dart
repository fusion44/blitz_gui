// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_htlc_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const InvoiceHTLCState _$accepted = InvoiceHTLCState._('accepted');
const InvoiceHTLCState _$settled = InvoiceHTLCState._('settled');
const InvoiceHTLCState _$canceled = InvoiceHTLCState._('canceled');

InvoiceHTLCState _$valueOf(String name) {
  switch (name) {
    case 'accepted':
      return _$accepted;
    case 'settled':
      return _$settled;
    case 'canceled':
      return _$canceled;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<InvoiceHTLCState> _$values =
    BuiltSet<InvoiceHTLCState>(const <InvoiceHTLCState>[
  _$accepted,
  _$settled,
  _$canceled,
]);

class _$InvoiceHTLCStateMeta {
  const _$InvoiceHTLCStateMeta();
  InvoiceHTLCState get accepted => _$accepted;
  InvoiceHTLCState get settled => _$settled;
  InvoiceHTLCState get canceled => _$canceled;
  InvoiceHTLCState valueOf(String name) => _$valueOf(name);
  BuiltSet<InvoiceHTLCState> get values => _$values;
}

abstract class _$InvoiceHTLCStateMixin {
  // ignore: non_constant_identifier_names
  _$InvoiceHTLCStateMeta get InvoiceHTLCState => const _$InvoiceHTLCStateMeta();
}

Serializer<InvoiceHTLCState> _$invoiceHTLCStateSerializer =
    _$InvoiceHTLCStateSerializer();

class _$InvoiceHTLCStateSerializer
    implements PrimitiveSerializer<InvoiceHTLCState> {
  static const Map<String, Object> _toWire = <String, Object>{
    'accepted': 'accepted',
    'settled': 'settled',
    'canceled': 'canceled',
  };
  static const Map<Object, String> _fromWire = <Object, String>{
    'accepted': 'accepted',
    'settled': 'settled',
    'canceled': 'canceled',
  };

  @override
  final Iterable<Type> types = const <Type>[InvoiceHTLCState];
  @override
  final String wireName = 'InvoiceHTLCState';

  @override
  Object serialize(Serializers serializers, InvoiceHTLCState object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  InvoiceHTLCState deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      InvoiceHTLCState.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
