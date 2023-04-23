// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'htlc_attempt.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HTLCAttempt extends HTLCAttempt {
  @override
  final int attemptId;
  @override
  final HTLCStatus status;
  @override
  final Route route;
  @override
  final int attemptTimeNs;
  @override
  final int resolveTimeNs;
  @override
  final HTLCAttemptFailure failure;
  @override
  final String preimage;

  factory _$HTLCAttempt([void Function(HTLCAttemptBuilder)? updates]) =>
      (HTLCAttemptBuilder()..update(updates))._build();

  _$HTLCAttempt._(
      {required this.attemptId,
      required this.status,
      required this.route,
      required this.attemptTimeNs,
      required this.resolveTimeNs,
      required this.failure,
      required this.preimage})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        attemptId, r'HTLCAttempt', 'attemptId');
    BuiltValueNullFieldError.checkNotNull(status, r'HTLCAttempt', 'status');
    BuiltValueNullFieldError.checkNotNull(route, r'HTLCAttempt', 'route');
    BuiltValueNullFieldError.checkNotNull(
        attemptTimeNs, r'HTLCAttempt', 'attemptTimeNs');
    BuiltValueNullFieldError.checkNotNull(
        resolveTimeNs, r'HTLCAttempt', 'resolveTimeNs');
    BuiltValueNullFieldError.checkNotNull(failure, r'HTLCAttempt', 'failure');
    BuiltValueNullFieldError.checkNotNull(preimage, r'HTLCAttempt', 'preimage');
  }

  @override
  HTLCAttempt rebuild(void Function(HTLCAttemptBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HTLCAttemptBuilder toBuilder() => HTLCAttemptBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HTLCAttempt &&
        attemptId == other.attemptId &&
        status == other.status &&
        route == other.route &&
        attemptTimeNs == other.attemptTimeNs &&
        resolveTimeNs == other.resolveTimeNs &&
        failure == other.failure &&
        preimage == other.preimage;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, attemptId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, route.hashCode);
    _$hash = $jc(_$hash, attemptTimeNs.hashCode);
    _$hash = $jc(_$hash, resolveTimeNs.hashCode);
    _$hash = $jc(_$hash, failure.hashCode);
    _$hash = $jc(_$hash, preimage.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HTLCAttempt')
          ..add('attemptId', attemptId)
          ..add('status', status)
          ..add('route', route)
          ..add('attemptTimeNs', attemptTimeNs)
          ..add('resolveTimeNs', resolveTimeNs)
          ..add('failure', failure)
          ..add('preimage', preimage))
        .toString();
  }
}

class HTLCAttemptBuilder implements Builder<HTLCAttempt, HTLCAttemptBuilder> {
  _$HTLCAttempt? _$v;

  int? _attemptId;
  int? get attemptId => _$this._attemptId;
  set attemptId(int? attemptId) => _$this._attemptId = attemptId;

  HTLCStatus? _status;
  HTLCStatus? get status => _$this._status;
  set status(HTLCStatus? status) => _$this._status = status;

  RouteBuilder? _route;
  RouteBuilder get route => _$this._route ??= RouteBuilder();
  set route(RouteBuilder? route) => _$this._route = route;

  int? _attemptTimeNs;
  int? get attemptTimeNs => _$this._attemptTimeNs;
  set attemptTimeNs(int? attemptTimeNs) =>
      _$this._attemptTimeNs = attemptTimeNs;

  int? _resolveTimeNs;
  int? get resolveTimeNs => _$this._resolveTimeNs;
  set resolveTimeNs(int? resolveTimeNs) =>
      _$this._resolveTimeNs = resolveTimeNs;

  HTLCAttemptFailureBuilder? _failure;
  HTLCAttemptFailureBuilder get failure =>
      _$this._failure ??= HTLCAttemptFailureBuilder();
  set failure(HTLCAttemptFailureBuilder? failure) => _$this._failure = failure;

  String? _preimage;
  String? get preimage => _$this._preimage;
  set preimage(String? preimage) => _$this._preimage = preimage;

  HTLCAttemptBuilder() {
    HTLCAttempt._defaults(this);
  }

  HTLCAttemptBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _attemptId = $v.attemptId;
      _status = $v.status;
      _route = $v.route.toBuilder();
      _attemptTimeNs = $v.attemptTimeNs;
      _resolveTimeNs = $v.resolveTimeNs;
      _failure = $v.failure.toBuilder();
      _preimage = $v.preimage;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HTLCAttempt other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$HTLCAttempt;
  }

  @override
  void update(void Function(HTLCAttemptBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HTLCAttempt build() => _build();

  _$HTLCAttempt _build() {
    _$HTLCAttempt _$result;
    try {
      _$result = _$v ??
          _$HTLCAttempt._(
              attemptId: BuiltValueNullFieldError.checkNotNull(
                  attemptId, r'HTLCAttempt', 'attemptId'),
              status: BuiltValueNullFieldError.checkNotNull(
                  status, r'HTLCAttempt', 'status'),
              route: route.build(),
              attemptTimeNs: BuiltValueNullFieldError.checkNotNull(
                  attemptTimeNs, r'HTLCAttempt', 'attemptTimeNs'),
              resolveTimeNs: BuiltValueNullFieldError.checkNotNull(
                  resolveTimeNs, r'HTLCAttempt', 'resolveTimeNs'),
              failure: failure.build(),
              preimage: BuiltValueNullFieldError.checkNotNull(
                  preimage, r'HTLCAttempt', 'preimage'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'route';
        route.build();

        _$failedField = 'failure';
        failure.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'HTLCAttempt', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
