// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_coins_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SendCoinsResponse extends SendCoinsResponse {
  @override
  final String txid;
  @override
  final String address;
  @override
  final int amount;
  @override
  final int? fees;
  @override
  final String? label;
  @override
  final bool? sendAll;

  factory _$SendCoinsResponse(
          [void Function(SendCoinsResponseBuilder)? updates]) =>
      (SendCoinsResponseBuilder()..update(updates))._build();

  _$SendCoinsResponse._(
      {required this.txid,
      required this.address,
      required this.amount,
      this.fees,
      this.label,
      this.sendAll})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(txid, r'SendCoinsResponse', 'txid');
    BuiltValueNullFieldError.checkNotNull(
        address, r'SendCoinsResponse', 'address');
    BuiltValueNullFieldError.checkNotNull(
        amount, r'SendCoinsResponse', 'amount');
  }

  @override
  SendCoinsResponse rebuild(void Function(SendCoinsResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SendCoinsResponseBuilder toBuilder() =>
      SendCoinsResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SendCoinsResponse &&
        txid == other.txid &&
        address == other.address &&
        amount == other.amount &&
        fees == other.fees &&
        label == other.label &&
        sendAll == other.sendAll;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, txid.hashCode);
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, fees.hashCode);
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jc(_$hash, sendAll.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SendCoinsResponse')
          ..add('txid', txid)
          ..add('address', address)
          ..add('amount', amount)
          ..add('fees', fees)
          ..add('label', label)
          ..add('sendAll', sendAll))
        .toString();
  }
}

class SendCoinsResponseBuilder
    implements Builder<SendCoinsResponse, SendCoinsResponseBuilder> {
  _$SendCoinsResponse? _$v;

  String? _txid;
  String? get txid => _$this._txid;
  set txid(String? txid) => _$this._txid = txid;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  int? _amount;
  int? get amount => _$this._amount;
  set amount(int? amount) => _$this._amount = amount;

  int? _fees;
  int? get fees => _$this._fees;
  set fees(int? fees) => _$this._fees = fees;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  bool? _sendAll;
  bool? get sendAll => _$this._sendAll;
  set sendAll(bool? sendAll) => _$this._sendAll = sendAll;

  SendCoinsResponseBuilder() {
    SendCoinsResponse._defaults(this);
  }

  SendCoinsResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _txid = $v.txid;
      _address = $v.address;
      _amount = $v.amount;
      _fees = $v.fees;
      _label = $v.label;
      _sendAll = $v.sendAll;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SendCoinsResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SendCoinsResponse;
  }

  @override
  void update(void Function(SendCoinsResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SendCoinsResponse build() => _build();

  _$SendCoinsResponse _build() {
    final _$result = _$v ??
        _$SendCoinsResponse._(
            txid: BuiltValueNullFieldError.checkNotNull(
                txid, r'SendCoinsResponse', 'txid'),
            address: BuiltValueNullFieldError.checkNotNull(
                address, r'SendCoinsResponse', 'address'),
            amount: BuiltValueNullFieldError.checkNotNull(
                amount, r'SendCoinsResponse', 'amount'),
            fees: fees,
            label: label,
            sendAll: sendAll);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
