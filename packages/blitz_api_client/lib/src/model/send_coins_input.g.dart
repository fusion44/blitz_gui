// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_coins_input.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SendCoinsInput extends SendCoinsInput {
  @override
  final String address;
  @override
  final int? targetConf;
  @override
  final int? satPerVbyte;
  @override
  final int? minConfs;
  @override
  final String? label;
  @override
  final bool? sendAll;
  @override
  final int? amount;

  factory _$SendCoinsInput([void Function(SendCoinsInputBuilder)? updates]) =>
      (SendCoinsInputBuilder()..update(updates))._build();

  _$SendCoinsInput._(
      {required this.address,
      this.targetConf,
      this.satPerVbyte,
      this.minConfs,
      this.label,
      this.sendAll,
      this.amount})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        address, r'SendCoinsInput', 'address');
  }

  @override
  SendCoinsInput rebuild(void Function(SendCoinsInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SendCoinsInputBuilder toBuilder() => SendCoinsInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SendCoinsInput &&
        address == other.address &&
        targetConf == other.targetConf &&
        satPerVbyte == other.satPerVbyte &&
        minConfs == other.minConfs &&
        label == other.label &&
        sendAll == other.sendAll &&
        amount == other.amount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, targetConf.hashCode);
    _$hash = $jc(_$hash, satPerVbyte.hashCode);
    _$hash = $jc(_$hash, minConfs.hashCode);
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jc(_$hash, sendAll.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SendCoinsInput')
          ..add('address', address)
          ..add('targetConf', targetConf)
          ..add('satPerVbyte', satPerVbyte)
          ..add('minConfs', minConfs)
          ..add('label', label)
          ..add('sendAll', sendAll)
          ..add('amount', amount))
        .toString();
  }
}

class SendCoinsInputBuilder
    implements Builder<SendCoinsInput, SendCoinsInputBuilder> {
  _$SendCoinsInput? _$v;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  int? _targetConf;
  int? get targetConf => _$this._targetConf;
  set targetConf(int? targetConf) => _$this._targetConf = targetConf;

  int? _satPerVbyte;
  int? get satPerVbyte => _$this._satPerVbyte;
  set satPerVbyte(int? satPerVbyte) => _$this._satPerVbyte = satPerVbyte;

  int? _minConfs;
  int? get minConfs => _$this._minConfs;
  set minConfs(int? minConfs) => _$this._minConfs = minConfs;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  bool? _sendAll;
  bool? get sendAll => _$this._sendAll;
  set sendAll(bool? sendAll) => _$this._sendAll = sendAll;

  int? _amount;
  int? get amount => _$this._amount;
  set amount(int? amount) => _$this._amount = amount;

  SendCoinsInputBuilder() {
    SendCoinsInput._defaults(this);
  }

  SendCoinsInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _address = $v.address;
      _targetConf = $v.targetConf;
      _satPerVbyte = $v.satPerVbyte;
      _minConfs = $v.minConfs;
      _label = $v.label;
      _sendAll = $v.sendAll;
      _amount = $v.amount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SendCoinsInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SendCoinsInput;
  }

  @override
  void update(void Function(SendCoinsInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SendCoinsInput build() => _build();

  _$SendCoinsInput _build() {
    final _$result = _$v ??
        _$SendCoinsInput._(
            address: BuiltValueNullFieldError.checkNotNull(
                address, r'SendCoinsInput', 'address'),
            targetConf: targetConf,
            satPerVbyte: satPerVbyte,
            minConfs: minConfs,
            label: label,
            sendAll: sendAll,
            amount: amount);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
