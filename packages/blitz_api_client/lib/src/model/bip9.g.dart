// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bip9.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Bip9 extends Bip9 {
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

  factory _$Bip9([void Function(Bip9Builder)? updates]) =>
      (Bip9Builder()..update(updates))._build();

  _$Bip9._(
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
    BuiltValueNullFieldError.checkNotNull(status, r'Bip9', 'status');
    BuiltValueNullFieldError.checkNotNull(startTime, r'Bip9', 'startTime');
    BuiltValueNullFieldError.checkNotNull(timeout, r'Bip9', 'timeout');
    BuiltValueNullFieldError.checkNotNull(since, r'Bip9', 'since');
    BuiltValueNullFieldError.checkNotNull(
        minActivationHeight, r'Bip9', 'minActivationHeight');
  }

  @override
  Bip9 rebuild(void Function(Bip9Builder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Bip9Builder toBuilder() => Bip9Builder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Bip9 &&
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
    return (newBuiltValueToStringHelper(r'Bip9')
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

class Bip9Builder implements Builder<Bip9, Bip9Builder> {
  _$Bip9? _$v;

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

  Bip9Builder() {
    Bip9._defaults(this);
  }

  Bip9Builder get _$this {
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
  void replace(Bip9 other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Bip9;
  }

  @override
  void update(void Function(Bip9Builder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Bip9 build() => _build();

  _$Bip9 _build() {
    _$Bip9 _$result;
    try {
      _$result = _$v ??
          _$Bip9._(
              status: BuiltValueNullFieldError.checkNotNull(
                  status, r'Bip9', 'status'),
              bit: bit,
              startTime: BuiltValueNullFieldError.checkNotNull(
                  startTime, r'Bip9', 'startTime'),
              timeout: BuiltValueNullFieldError.checkNotNull(
                  timeout, r'Bip9', 'timeout'),
              since: BuiltValueNullFieldError.checkNotNull(
                  since, r'Bip9', 'since'),
              minActivationHeight: BuiltValueNullFieldError.checkNotNull(
                  minActivationHeight, r'Bip9', 'minActivationHeight'),
              statistics: _statistics?.build(),
              height: height,
              active: active);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'statistics';
        _statistics?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(r'Bip9', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
