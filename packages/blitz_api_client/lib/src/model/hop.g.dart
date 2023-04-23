// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hop.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Hop extends Hop {
  @override
  final int chanId;
  @override
  final int chanCapacity;
  @override
  final int amtToForward;
  @override
  final int fee;
  @override
  final int expiry;
  @override
  final int amtToForwardMsat;
  @override
  final int feeMsat;
  @override
  final String pubKey;
  @override
  final bool tlvPayload;

  factory _$Hop([void Function(HopBuilder)? updates]) =>
      (HopBuilder()..update(updates))._build();

  _$Hop._(
      {required this.chanId,
      required this.chanCapacity,
      required this.amtToForward,
      required this.fee,
      required this.expiry,
      required this.amtToForwardMsat,
      required this.feeMsat,
      required this.pubKey,
      required this.tlvPayload})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(chanId, r'Hop', 'chanId');
    BuiltValueNullFieldError.checkNotNull(chanCapacity, r'Hop', 'chanCapacity');
    BuiltValueNullFieldError.checkNotNull(amtToForward, r'Hop', 'amtToForward');
    BuiltValueNullFieldError.checkNotNull(fee, r'Hop', 'fee');
    BuiltValueNullFieldError.checkNotNull(expiry, r'Hop', 'expiry');
    BuiltValueNullFieldError.checkNotNull(
        amtToForwardMsat, r'Hop', 'amtToForwardMsat');
    BuiltValueNullFieldError.checkNotNull(feeMsat, r'Hop', 'feeMsat');
    BuiltValueNullFieldError.checkNotNull(pubKey, r'Hop', 'pubKey');
    BuiltValueNullFieldError.checkNotNull(tlvPayload, r'Hop', 'tlvPayload');
  }

  @override
  Hop rebuild(void Function(HopBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HopBuilder toBuilder() => HopBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hop &&
        chanId == other.chanId &&
        chanCapacity == other.chanCapacity &&
        amtToForward == other.amtToForward &&
        fee == other.fee &&
        expiry == other.expiry &&
        amtToForwardMsat == other.amtToForwardMsat &&
        feeMsat == other.feeMsat &&
        pubKey == other.pubKey &&
        tlvPayload == other.tlvPayload;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, chanId.hashCode);
    _$hash = $jc(_$hash, chanCapacity.hashCode);
    _$hash = $jc(_$hash, amtToForward.hashCode);
    _$hash = $jc(_$hash, fee.hashCode);
    _$hash = $jc(_$hash, expiry.hashCode);
    _$hash = $jc(_$hash, amtToForwardMsat.hashCode);
    _$hash = $jc(_$hash, feeMsat.hashCode);
    _$hash = $jc(_$hash, pubKey.hashCode);
    _$hash = $jc(_$hash, tlvPayload.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hop')
          ..add('chanId', chanId)
          ..add('chanCapacity', chanCapacity)
          ..add('amtToForward', amtToForward)
          ..add('fee', fee)
          ..add('expiry', expiry)
          ..add('amtToForwardMsat', amtToForwardMsat)
          ..add('feeMsat', feeMsat)
          ..add('pubKey', pubKey)
          ..add('tlvPayload', tlvPayload))
        .toString();
  }
}

class HopBuilder implements Builder<Hop, HopBuilder> {
  _$Hop? _$v;

  int? _chanId;
  int? get chanId => _$this._chanId;
  set chanId(int? chanId) => _$this._chanId = chanId;

  int? _chanCapacity;
  int? get chanCapacity => _$this._chanCapacity;
  set chanCapacity(int? chanCapacity) => _$this._chanCapacity = chanCapacity;

  int? _amtToForward;
  int? get amtToForward => _$this._amtToForward;
  set amtToForward(int? amtToForward) => _$this._amtToForward = amtToForward;

  int? _fee;
  int? get fee => _$this._fee;
  set fee(int? fee) => _$this._fee = fee;

  int? _expiry;
  int? get expiry => _$this._expiry;
  set expiry(int? expiry) => _$this._expiry = expiry;

  int? _amtToForwardMsat;
  int? get amtToForwardMsat => _$this._amtToForwardMsat;
  set amtToForwardMsat(int? amtToForwardMsat) =>
      _$this._amtToForwardMsat = amtToForwardMsat;

  int? _feeMsat;
  int? get feeMsat => _$this._feeMsat;
  set feeMsat(int? feeMsat) => _$this._feeMsat = feeMsat;

  String? _pubKey;
  String? get pubKey => _$this._pubKey;
  set pubKey(String? pubKey) => _$this._pubKey = pubKey;

  bool? _tlvPayload;
  bool? get tlvPayload => _$this._tlvPayload;
  set tlvPayload(bool? tlvPayload) => _$this._tlvPayload = tlvPayload;

  HopBuilder() {
    Hop._defaults(this);
  }

  HopBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _chanId = $v.chanId;
      _chanCapacity = $v.chanCapacity;
      _amtToForward = $v.amtToForward;
      _fee = $v.fee;
      _expiry = $v.expiry;
      _amtToForwardMsat = $v.amtToForwardMsat;
      _feeMsat = $v.feeMsat;
      _pubKey = $v.pubKey;
      _tlvPayload = $v.tlvPayload;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hop other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Hop;
  }

  @override
  void update(void Function(HopBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hop build() => _build();

  _$Hop _build() {
    final _$result = _$v ??
        _$Hop._(
            chanId:
                BuiltValueNullFieldError.checkNotNull(chanId, r'Hop', 'chanId'),
            chanCapacity: BuiltValueNullFieldError.checkNotNull(
                chanCapacity, r'Hop', 'chanCapacity'),
            amtToForward: BuiltValueNullFieldError.checkNotNull(
                amtToForward, r'Hop', 'amtToForward'),
            fee: BuiltValueNullFieldError.checkNotNull(fee, r'Hop', 'fee'),
            expiry:
                BuiltValueNullFieldError.checkNotNull(expiry, r'Hop', 'expiry'),
            amtToForwardMsat: BuiltValueNullFieldError.checkNotNull(
                amtToForwardMsat, r'Hop', 'amtToForwardMsat'),
            feeMsat: BuiltValueNullFieldError.checkNotNull(
                feeMsat, r'Hop', 'feeMsat'),
            pubKey:
                BuiltValueNullFieldError.checkNotNull(pubKey, r'Hop', 'pubKey'),
            tlvPayload: BuiltValueNullFieldError.checkNotNull(
                tlvPayload, r'Hop', 'tlvPayload'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
