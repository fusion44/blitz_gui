// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mpp_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MPPRecord extends MPPRecord {
  @override
  final String paymentAddr;
  @override
  final int totalAmtMsat;

  factory _$MPPRecord([void Function(MPPRecordBuilder)? updates]) =>
      (MPPRecordBuilder()..update(updates))._build();

  _$MPPRecord._({required this.paymentAddr, required this.totalAmtMsat})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        paymentAddr, r'MPPRecord', 'paymentAddr');
    BuiltValueNullFieldError.checkNotNull(
        totalAmtMsat, r'MPPRecord', 'totalAmtMsat');
  }

  @override
  MPPRecord rebuild(void Function(MPPRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MPPRecordBuilder toBuilder() => MPPRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MPPRecord &&
        paymentAddr == other.paymentAddr &&
        totalAmtMsat == other.totalAmtMsat;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, paymentAddr.hashCode);
    _$hash = $jc(_$hash, totalAmtMsat.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MPPRecord')
          ..add('paymentAddr', paymentAddr)
          ..add('totalAmtMsat', totalAmtMsat))
        .toString();
  }
}

class MPPRecordBuilder implements Builder<MPPRecord, MPPRecordBuilder> {
  _$MPPRecord? _$v;

  String? _paymentAddr;
  String? get paymentAddr => _$this._paymentAddr;
  set paymentAddr(String? paymentAddr) => _$this._paymentAddr = paymentAddr;

  int? _totalAmtMsat;
  int? get totalAmtMsat => _$this._totalAmtMsat;
  set totalAmtMsat(int? totalAmtMsat) => _$this._totalAmtMsat = totalAmtMsat;

  MPPRecordBuilder() {
    MPPRecord._defaults(this);
  }

  MPPRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _paymentAddr = $v.paymentAddr;
      _totalAmtMsat = $v.totalAmtMsat;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MPPRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MPPRecord;
  }

  @override
  void update(void Function(MPPRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MPPRecord build() => _build();

  _$MPPRecord _build() {
    final _$result = _$v ??
        _$MPPRecord._(
            paymentAddr: BuiltValueNullFieldError.checkNotNull(
                paymentAddr, r'MPPRecord', 'paymentAddr'),
            totalAmtMsat: BuiltValueNullFieldError.checkNotNull(
                totalAmtMsat, r'MPPRecord', 'totalAmtMsat'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
