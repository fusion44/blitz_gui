// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistics.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Statistics extends Statistics {
  @override
  final int period;
  @override
  final int threshold;
  @override
  final int elapsed;
  @override
  final int count;
  @override
  final bool possible;

  factory _$Statistics([void Function(StatisticsBuilder)? updates]) =>
      (StatisticsBuilder()..update(updates))._build();

  _$Statistics._(
      {required this.period,
      required this.threshold,
      required this.elapsed,
      required this.count,
      required this.possible})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(period, r'Statistics', 'period');
    BuiltValueNullFieldError.checkNotNull(
        threshold, r'Statistics', 'threshold');
    BuiltValueNullFieldError.checkNotNull(elapsed, r'Statistics', 'elapsed');
    BuiltValueNullFieldError.checkNotNull(count, r'Statistics', 'count');
    BuiltValueNullFieldError.checkNotNull(possible, r'Statistics', 'possible');
  }

  @override
  Statistics rebuild(void Function(StatisticsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StatisticsBuilder toBuilder() => StatisticsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Statistics &&
        period == other.period &&
        threshold == other.threshold &&
        elapsed == other.elapsed &&
        count == other.count &&
        possible == other.possible;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, period.hashCode);
    _$hash = $jc(_$hash, threshold.hashCode);
    _$hash = $jc(_$hash, elapsed.hashCode);
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jc(_$hash, possible.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Statistics')
          ..add('period', period)
          ..add('threshold', threshold)
          ..add('elapsed', elapsed)
          ..add('count', count)
          ..add('possible', possible))
        .toString();
  }
}

class StatisticsBuilder implements Builder<Statistics, StatisticsBuilder> {
  _$Statistics? _$v;

  int? _period;
  int? get period => _$this._period;
  set period(int? period) => _$this._period = period;

  int? _threshold;
  int? get threshold => _$this._threshold;
  set threshold(int? threshold) => _$this._threshold = threshold;

  int? _elapsed;
  int? get elapsed => _$this._elapsed;
  set elapsed(int? elapsed) => _$this._elapsed = elapsed;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  bool? _possible;
  bool? get possible => _$this._possible;
  set possible(bool? possible) => _$this._possible = possible;

  StatisticsBuilder() {
    Statistics._defaults(this);
  }

  StatisticsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _period = $v.period;
      _threshold = $v.threshold;
      _elapsed = $v.elapsed;
      _count = $v.count;
      _possible = $v.possible;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Statistics other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Statistics;
  }

  @override
  void update(void Function(StatisticsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Statistics build() => _build();

  _$Statistics _build() {
    final _$result = _$v ??
        _$Statistics._(
            period: BuiltValueNullFieldError.checkNotNull(
                period, r'Statistics', 'period'),
            threshold: BuiltValueNullFieldError.checkNotNull(
                threshold, r'Statistics', 'threshold'),
            elapsed: BuiltValueNullFieldError.checkNotNull(
                elapsed, r'Statistics', 'elapsed'),
            count: BuiltValueNullFieldError.checkNotNull(
                count, r'Statistics', 'count'),
            possible: BuiltValueNullFieldError.checkNotNull(
                possible, r'Statistics', 'possible'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
