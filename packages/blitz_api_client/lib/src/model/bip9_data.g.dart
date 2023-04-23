// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bip9_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Bip9Data extends Bip9Data {
  @override
  final String status;
  @override
  final int? bit;
  @override
  final int startTime;
  @override
  final int timeout;
  @override
  final int since;
  @override
  final int minActivationHeight;
  @override
  final Statistics? statistics;
  @override
  final int? height;
  @override
  final bool? active;

  factory _$Bip9Data([void Function(Bip9DataBuilder)? updates]) =>
      (Bip9DataBuilder()..update(updates))._build();

  _$Bip9Data._(
      {required this.status,
      this.bit,
      required this.startTime,
      required this.timeout,
      required this.since,
      required this.minActivationHeight,
      this.statistics,
      this.height,
      this.active})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(status, r'Bip9Data', 'status');
    BuiltValueNullFieldError.checkNotNull(startTime, r'Bip9Data', 'startTime');
    BuiltValueNullFieldError.checkNotNull(timeout, r'Bip9Data', 'timeout');
    BuiltValueNullFieldError.checkNotNull(since, r'Bip9Data', 'since');
    BuiltValueNullFieldError.checkNotNull(
        minActivationHeight, r'Bip9Data', 'minActivationHeight');
  }

  @override
  Bip9Data rebuild(void Function(Bip9DataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Bip9DataBuilder toBuilder() => Bip9DataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Bip9Data &&
        status == other.status &&
        bit == other.bit &&
        startTime == other.startTime &&
        timeout == other.timeout &&
        since == other.since &&
        minActivationHeight == other.minActivationHeight &&
        statistics == other.statistics &&
        height == other.height &&
        active == other.active;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, bit.hashCode);
    _$hash = $jc(_$hash, startTime.hashCode);
    _$hash = $jc(_$hash, timeout.hashCode);
    _$hash = $jc(_$hash, since.hashCode);
    _$hash = $jc(_$hash, minActivationHeight.hashCode);
    _$hash = $jc(_$hash, statistics.hashCode);
    _$hash = $jc(_$hash, height.hashCode);
    _$hash = $jc(_$hash, active.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Bip9Data')
          ..add('status', status)
          ..add('bit', bit)
          ..add('startTime', startTime)
          ..add('timeout', timeout)
          ..add('since', since)
          ..add('minActivationHeight', minActivationHeight)
          ..add('statistics', statistics)
          ..add('height', height)
          ..add('active', active))
        .toString();
  }
}

class Bip9DataBuilder implements Builder<Bip9Data, Bip9DataBuilder> {
  _$Bip9Data? _$v;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  int? _bit;
  int? get bit => _$this._bit;
  set bit(int? bit) => _$this._bit = bit;

  int? _startTime;
  int? get startTime => _$this._startTime;
  set startTime(int? startTime) => _$this._startTime = startTime;

  int? _timeout;
  int? get timeout => _$this._timeout;
  set timeout(int? timeout) => _$this._timeout = timeout;

  int? _since;
  int? get since => _$this._since;
  set since(int? since) => _$this._since = since;

  int? _minActivationHeight;
  int? get minActivationHeight => _$this._minActivationHeight;
  set minActivationHeight(int? minActivationHeight) =>
      _$this._minActivationHeight = minActivationHeight;

  StatisticsBuilder? _statistics;
  StatisticsBuilder get statistics =>
      _$this._statistics ??= StatisticsBuilder();
  set statistics(StatisticsBuilder? statistics) =>
      _$this._statistics = statistics;

  int? _height;
  int? get height => _$this._height;
  set height(int? height) => _$this._height = height;

  bool? _active;
  bool? get active => _$this._active;
  set active(bool? active) => _$this._active = active;

  Bip9DataBuilder() {
    Bip9Data._defaults(this);
  }

  Bip9DataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _bit = $v.bit;
      _startTime = $v.startTime;
      _timeout = $v.timeout;
      _since = $v.since;
      _minActivationHeight = $v.minActivationHeight;
      _statistics = $v.statistics?.toBuilder();
      _height = $v.height;
      _active = $v.active;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Bip9Data other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Bip9Data;
  }

  @override
  void update(void Function(Bip9DataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Bip9Data build() => _build();

  _$Bip9Data _build() {
    _$Bip9Data _$result;
    try {
      _$result = _$v ??
          _$Bip9Data._(
              status: BuiltValueNullFieldError.checkNotNull(
                  status, r'Bip9Data', 'status'),
              bit: bit,
              startTime: BuiltValueNullFieldError.checkNotNull(
                  startTime, r'Bip9Data', 'startTime'),
              timeout: BuiltValueNullFieldError.checkNotNull(
                  timeout, r'Bip9Data', 'timeout'),
              since: BuiltValueNullFieldError.checkNotNull(
                  since, r'Bip9Data', 'since'),
              minActivationHeight: BuiltValueNullFieldError.checkNotNull(
                  minActivationHeight, r'Bip9Data', 'minActivationHeight'),
              statistics: _statistics?.build(),
              height: height,
              active: active);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'statistics';
        _statistics?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Bip9Data', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
