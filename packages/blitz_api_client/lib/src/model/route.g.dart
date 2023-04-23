// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Route extends Route {
  @override
  final int totalTimeLock;
  @override
  final int totalFees;
  @override
  final int totalAmt;
  @override
  final BuiltList<Hop> hops;
  @override
  final int totalFeesMsat;
  @override
  final int totalAmtMsat;
  @override
  final MPPRecord? mppRecord;
  @override
  final AMPRecord? ampRecord;
  @override
  final BuiltList<CustomRecordsEntry> customRecords;

  factory _$Route([void Function(RouteBuilder)? updates]) =>
      (RouteBuilder()..update(updates))._build();

  _$Route._(
      {required this.totalTimeLock,
      required this.totalFees,
      required this.totalAmt,
      required this.hops,
      required this.totalFeesMsat,
      required this.totalAmtMsat,
      this.mppRecord,
      this.ampRecord,
      required this.customRecords})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        totalTimeLock, r'Route', 'totalTimeLock');
    BuiltValueNullFieldError.checkNotNull(totalFees, r'Route', 'totalFees');
    BuiltValueNullFieldError.checkNotNull(totalAmt, r'Route', 'totalAmt');
    BuiltValueNullFieldError.checkNotNull(hops, r'Route', 'hops');
    BuiltValueNullFieldError.checkNotNull(
        totalFeesMsat, r'Route', 'totalFeesMsat');
    BuiltValueNullFieldError.checkNotNull(
        totalAmtMsat, r'Route', 'totalAmtMsat');
    BuiltValueNullFieldError.checkNotNull(
        customRecords, r'Route', 'customRecords');
  }

  @override
  Route rebuild(void Function(RouteBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RouteBuilder toBuilder() => RouteBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Route &&
        totalTimeLock == other.totalTimeLock &&
        totalFees == other.totalFees &&
        totalAmt == other.totalAmt &&
        hops == other.hops &&
        totalFeesMsat == other.totalFeesMsat &&
        totalAmtMsat == other.totalAmtMsat &&
        mppRecord == other.mppRecord &&
        ampRecord == other.ampRecord &&
        customRecords == other.customRecords;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, totalTimeLock.hashCode);
    _$hash = $jc(_$hash, totalFees.hashCode);
    _$hash = $jc(_$hash, totalAmt.hashCode);
    _$hash = $jc(_$hash, hops.hashCode);
    _$hash = $jc(_$hash, totalFeesMsat.hashCode);
    _$hash = $jc(_$hash, totalAmtMsat.hashCode);
    _$hash = $jc(_$hash, mppRecord.hashCode);
    _$hash = $jc(_$hash, ampRecord.hashCode);
    _$hash = $jc(_$hash, customRecords.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Route')
          ..add('totalTimeLock', totalTimeLock)
          ..add('totalFees', totalFees)
          ..add('totalAmt', totalAmt)
          ..add('hops', hops)
          ..add('totalFeesMsat', totalFeesMsat)
          ..add('totalAmtMsat', totalAmtMsat)
          ..add('mppRecord', mppRecord)
          ..add('ampRecord', ampRecord)
          ..add('customRecords', customRecords))
        .toString();
  }
}

class RouteBuilder implements Builder<Route, RouteBuilder> {
  _$Route? _$v;

  int? _totalTimeLock;
  int? get totalTimeLock => _$this._totalTimeLock;
  set totalTimeLock(int? totalTimeLock) =>
      _$this._totalTimeLock = totalTimeLock;

  int? _totalFees;
  int? get totalFees => _$this._totalFees;
  set totalFees(int? totalFees) => _$this._totalFees = totalFees;

  int? _totalAmt;
  int? get totalAmt => _$this._totalAmt;
  set totalAmt(int? totalAmt) => _$this._totalAmt = totalAmt;

  ListBuilder<Hop>? _hops;
  ListBuilder<Hop> get hops => _$this._hops ??= ListBuilder<Hop>();
  set hops(ListBuilder<Hop>? hops) => _$this._hops = hops;

  int? _totalFeesMsat;
  int? get totalFeesMsat => _$this._totalFeesMsat;
  set totalFeesMsat(int? totalFeesMsat) =>
      _$this._totalFeesMsat = totalFeesMsat;

  int? _totalAmtMsat;
  int? get totalAmtMsat => _$this._totalAmtMsat;
  set totalAmtMsat(int? totalAmtMsat) => _$this._totalAmtMsat = totalAmtMsat;

  MPPRecordBuilder? _mppRecord;
  MPPRecordBuilder get mppRecord => _$this._mppRecord ??= MPPRecordBuilder();
  set mppRecord(MPPRecordBuilder? mppRecord) => _$this._mppRecord = mppRecord;

  AMPRecordBuilder? _ampRecord;
  AMPRecordBuilder get ampRecord => _$this._ampRecord ??= AMPRecordBuilder();
  set ampRecord(AMPRecordBuilder? ampRecord) => _$this._ampRecord = ampRecord;

  ListBuilder<CustomRecordsEntry>? _customRecords;
  ListBuilder<CustomRecordsEntry> get customRecords =>
      _$this._customRecords ??= ListBuilder<CustomRecordsEntry>();
  set customRecords(ListBuilder<CustomRecordsEntry>? customRecords) =>
      _$this._customRecords = customRecords;

  RouteBuilder() {
    Route._defaults(this);
  }

  RouteBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _totalTimeLock = $v.totalTimeLock;
      _totalFees = $v.totalFees;
      _totalAmt = $v.totalAmt;
      _hops = $v.hops.toBuilder();
      _totalFeesMsat = $v.totalFeesMsat;
      _totalAmtMsat = $v.totalAmtMsat;
      _mppRecord = $v.mppRecord?.toBuilder();
      _ampRecord = $v.ampRecord?.toBuilder();
      _customRecords = $v.customRecords.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Route other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Route;
  }

  @override
  void update(void Function(RouteBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Route build() => _build();

  _$Route _build() {
    _$Route _$result;
    try {
      _$result = _$v ??
          _$Route._(
              totalTimeLock: BuiltValueNullFieldError.checkNotNull(
                  totalTimeLock, r'Route', 'totalTimeLock'),
              totalFees: BuiltValueNullFieldError.checkNotNull(
                  totalFees, r'Route', 'totalFees'),
              totalAmt: BuiltValueNullFieldError.checkNotNull(
                  totalAmt, r'Route', 'totalAmt'),
              hops: hops.build(),
              totalFeesMsat: BuiltValueNullFieldError.checkNotNull(
                  totalFeesMsat, r'Route', 'totalFeesMsat'),
              totalAmtMsat: BuiltValueNullFieldError.checkNotNull(
                  totalAmtMsat, r'Route', 'totalAmtMsat'),
              mppRecord: _mppRecord?.build(),
              ampRecord: _ampRecord?.build(),
              customRecords: customRecords.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'hops';
        hops.build();

        _$failedField = 'mppRecord';
        _mppRecord?.build();
        _$failedField = 'ampRecord';
        _ampRecord?.build();
        _$failedField = 'customRecords';
        customRecords.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(r'Route', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
