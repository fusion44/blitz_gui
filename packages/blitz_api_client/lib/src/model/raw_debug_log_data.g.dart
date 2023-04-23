// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'raw_debug_log_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RawDebugLogData extends RawDebugLogData {
  @override
  final String rawData;
  @override
  final String? githubIssuesUrl;

  factory _$RawDebugLogData([void Function(RawDebugLogDataBuilder)? updates]) =>
      (RawDebugLogDataBuilder()..update(updates))._build();

  _$RawDebugLogData._({required this.rawData, this.githubIssuesUrl})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        rawData, r'RawDebugLogData', 'rawData');
  }

  @override
  RawDebugLogData rebuild(void Function(RawDebugLogDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RawDebugLogDataBuilder toBuilder() => RawDebugLogDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RawDebugLogData &&
        rawData == other.rawData &&
        githubIssuesUrl == other.githubIssuesUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, rawData.hashCode);
    _$hash = $jc(_$hash, githubIssuesUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RawDebugLogData')
          ..add('rawData', rawData)
          ..add('githubIssuesUrl', githubIssuesUrl))
        .toString();
  }
}

class RawDebugLogDataBuilder
    implements Builder<RawDebugLogData, RawDebugLogDataBuilder> {
  _$RawDebugLogData? _$v;

  String? _rawData;
  String? get rawData => _$this._rawData;
  set rawData(String? rawData) => _$this._rawData = rawData;

  String? _githubIssuesUrl;
  String? get githubIssuesUrl => _$this._githubIssuesUrl;
  set githubIssuesUrl(String? githubIssuesUrl) =>
      _$this._githubIssuesUrl = githubIssuesUrl;

  RawDebugLogDataBuilder() {
    RawDebugLogData._defaults(this);
  }

  RawDebugLogDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _rawData = $v.rawData;
      _githubIssuesUrl = $v.githubIssuesUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RawDebugLogData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$RawDebugLogData;
  }

  @override
  void update(void Function(RawDebugLogDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RawDebugLogData build() => _build();

  _$RawDebugLogData _build() {
    final _$result = _$v ??
        _$RawDebugLogData._(
            rawData: BuiltValueNullFieldError.checkNotNull(
                rawData, r'RawDebugLogData', 'rawData'),
            githubIssuesUrl: githubIssuesUrl);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
