// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bip9_statistics.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Bip9Statistics extends Bip9Statistics {
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

  factory _$Bip9Statistics([void Function(Bip9StatisticsBuilder)? updates]) =>
      (Bip9StatisticsBuilder()..update(updates))._build();

  _$Bip9Statistics._(
      {required this.period,
      required this.threshold,
      required this.elapsed,
      required this.count,
      required this.possible})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(period, r'Bip9Statistics', 'period');
    BuiltValueNullFieldError.checkNotNull(
        threshold, r'Bip9Statistics', 'threshold');
    BuiltValueNullFieldError.checkNotNull(
        elapsed, r'Bip9Statistics', 'elapsed');
    BuiltValueNullFieldError.checkNotNull(count, r'Bip9Statistics', 'count');
    BuiltValueNullFieldError.checkNotNull(
        possible, r'Bip9Statistics', 'possible');
  }

  @override
  Bip9Statistics rebuild(void Function(Bip9StatisticsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Bip9StatisticsBuilder toBuilder() => Bip9StatisticsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Bip9Statistics &&
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
    return (newBuiltValueToStringHelper(r'Bip9Statistics')
          ..add('period', period)
          ..add('threshold', threshold)
          ..add('elapsed', elapsed)
          ..add('count', count)
          ..add('possible', possible))
        .toString();
  }
}

class Bip9StatisticsBuilder
    implements Builder<Bip9Statistics, Bip9StatisticsBuilder> {
  _$Bip9Statistics? _$v;

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

  Bip9StatisticsBuilder() {
    Bip9Statistics._defaults(this);
  }

  Bip9StatisticsBuilder get _$this {
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
  void replace(Bip9Statistics other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Bip9Statistics;
  }

  @override
  void update(void Function(Bip9StatisticsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Bip9Statistics build() => _build();

  _$Bip9Statistics _build() {
    final _$result = _$v ??
        _$Bip9Statistics._(
            period: BuiltValueNullFieldError.checkNotNull(
                period, r'Bip9Statistics', 'period'),
            threshold: BuiltValueNullFieldError.checkNotNull(
                threshold, r'Bip9Statistics', 'threshold'),
            elapsed: BuiltValueNullFieldError.checkNotNull(
                elapsed, r'Bip9Statistics', 'elapsed'),
            count: BuiltValueNullFieldError.checkNotNull(
                count, r'Bip9Statistics', 'count'),
            possible: BuiltValueNullFieldError.checkNotNull(
                possible, r'Bip9Statistics', 'possible'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
