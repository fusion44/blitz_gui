// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fee_revenue.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FeeRevenue extends FeeRevenue {
  @override
  final int day;
  @override
  final int week;
  @override
  final int month;
  @override
  final int? year;
  @override
  final int? total;

  factory _$FeeRevenue([void Function(FeeRevenueBuilder)? updates]) =>
      (FeeRevenueBuilder()..update(updates))._build();

  _$FeeRevenue._(
      {required this.day,
      required this.week,
      required this.month,
      this.year,
      this.total})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(day, r'FeeRevenue', 'day');
    BuiltValueNullFieldError.checkNotNull(week, r'FeeRevenue', 'week');
    BuiltValueNullFieldError.checkNotNull(month, r'FeeRevenue', 'month');
  }

  @override
  FeeRevenue rebuild(void Function(FeeRevenueBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FeeRevenueBuilder toBuilder() => FeeRevenueBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FeeRevenue &&
        day == other.day &&
        week == other.week &&
        month == other.month &&
        year == other.year &&
        total == other.total;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, day.hashCode);
    _$hash = $jc(_$hash, week.hashCode);
    _$hash = $jc(_$hash, month.hashCode);
    _$hash = $jc(_$hash, year.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FeeRevenue')
          ..add('day', day)
          ..add('week', week)
          ..add('month', month)
          ..add('year', year)
          ..add('total', total))
        .toString();
  }
}

class FeeRevenueBuilder implements Builder<FeeRevenue, FeeRevenueBuilder> {
  _$FeeRevenue? _$v;

  int? _day;
  int? get day => _$this._day;
  set day(int? day) => _$this._day = day;

  int? _week;
  int? get week => _$this._week;
  set week(int? week) => _$this._week = week;

  int? _month;
  int? get month => _$this._month;
  set month(int? month) => _$this._month = month;

  int? _year;
  int? get year => _$this._year;
  set year(int? year) => _$this._year = year;

  int? _total;
  int? get total => _$this._total;
  set total(int? total) => _$this._total = total;

  FeeRevenueBuilder() {
    FeeRevenue._defaults(this);
  }

  FeeRevenueBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _day = $v.day;
      _week = $v.week;
      _month = $v.month;
      _year = $v.year;
      _total = $v.total;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FeeRevenue other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$FeeRevenue;
  }

  @override
  void update(void Function(FeeRevenueBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FeeRevenue build() => _build();

  _$FeeRevenue _build() {
    final _$result = _$v ??
        _$FeeRevenue._(
            day: BuiltValueNullFieldError.checkNotNull(
                day, r'FeeRevenue', 'day'),
            week: BuiltValueNullFieldError.checkNotNull(
                week, r'FeeRevenue', 'week'),
            month: BuiltValueNullFieldError.checkNotNull(
                month, r'FeeRevenue', 'month'),
            year: year,
            total: total);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
