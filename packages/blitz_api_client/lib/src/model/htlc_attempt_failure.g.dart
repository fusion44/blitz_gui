// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'htlc_attempt_failure.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HTLCAttemptFailure extends HTLCAttemptFailure {
  @override
  final int code;
  @override
  final ChannelUpdate channelUpdate;
  @override
  final int htlcMsat;
  @override
  final String onionSha256;
  @override
  final int cltvExpiry;
  @override
  final int flags;
  @override
  final int failureSourceIndex;
  @override
  final int height;

  factory _$HTLCAttemptFailure(
          [void Function(HTLCAttemptFailureBuilder)? updates]) =>
      (HTLCAttemptFailureBuilder()..update(updates))._build();

  _$HTLCAttemptFailure._(
      {required this.code,
      required this.channelUpdate,
      required this.htlcMsat,
      required this.onionSha256,
      required this.cltvExpiry,
      required this.flags,
      required this.failureSourceIndex,
      required this.height})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(code, r'HTLCAttemptFailure', 'code');
    BuiltValueNullFieldError.checkNotNull(
        channelUpdate, r'HTLCAttemptFailure', 'channelUpdate');
    BuiltValueNullFieldError.checkNotNull(
        htlcMsat, r'HTLCAttemptFailure', 'htlcMsat');
    BuiltValueNullFieldError.checkNotNull(
        onionSha256, r'HTLCAttemptFailure', 'onionSha256');
    BuiltValueNullFieldError.checkNotNull(
        cltvExpiry, r'HTLCAttemptFailure', 'cltvExpiry');
    BuiltValueNullFieldError.checkNotNull(
        flags, r'HTLCAttemptFailure', 'flags');
    BuiltValueNullFieldError.checkNotNull(
        failureSourceIndex, r'HTLCAttemptFailure', 'failureSourceIndex');
    BuiltValueNullFieldError.checkNotNull(
        height, r'HTLCAttemptFailure', 'height');
  }

  @override
  HTLCAttemptFailure rebuild(
          void Function(HTLCAttemptFailureBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HTLCAttemptFailureBuilder toBuilder() =>
      HTLCAttemptFailureBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HTLCAttemptFailure &&
        code == other.code &&
        channelUpdate == other.channelUpdate &&
        htlcMsat == other.htlcMsat &&
        onionSha256 == other.onionSha256 &&
        cltvExpiry == other.cltvExpiry &&
        flags == other.flags &&
        failureSourceIndex == other.failureSourceIndex &&
        height == other.height;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, channelUpdate.hashCode);
    _$hash = $jc(_$hash, htlcMsat.hashCode);
    _$hash = $jc(_$hash, onionSha256.hashCode);
    _$hash = $jc(_$hash, cltvExpiry.hashCode);
    _$hash = $jc(_$hash, flags.hashCode);
    _$hash = $jc(_$hash, failureSourceIndex.hashCode);
    _$hash = $jc(_$hash, height.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HTLCAttemptFailure')
          ..add('code', code)
          ..add('channelUpdate', channelUpdate)
          ..add('htlcMsat', htlcMsat)
          ..add('onionSha256', onionSha256)
          ..add('cltvExpiry', cltvExpiry)
          ..add('flags', flags)
          ..add('failureSourceIndex', failureSourceIndex)
          ..add('height', height))
        .toString();
  }
}

class HTLCAttemptFailureBuilder
    implements Builder<HTLCAttemptFailure, HTLCAttemptFailureBuilder> {
  _$HTLCAttemptFailure? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ChannelUpdateBuilder? _channelUpdate;
  ChannelUpdateBuilder get channelUpdate =>
      _$this._channelUpdate ??= ChannelUpdateBuilder();
  set channelUpdate(ChannelUpdateBuilder? channelUpdate) =>
      _$this._channelUpdate = channelUpdate;

  int? _htlcMsat;
  int? get htlcMsat => _$this._htlcMsat;
  set htlcMsat(int? htlcMsat) => _$this._htlcMsat = htlcMsat;

  String? _onionSha256;
  String? get onionSha256 => _$this._onionSha256;
  set onionSha256(String? onionSha256) => _$this._onionSha256 = onionSha256;

  int? _cltvExpiry;
  int? get cltvExpiry => _$this._cltvExpiry;
  set cltvExpiry(int? cltvExpiry) => _$this._cltvExpiry = cltvExpiry;

  int? _flags;
  int? get flags => _$this._flags;
  set flags(int? flags) => _$this._flags = flags;

  int? _failureSourceIndex;
  int? get failureSourceIndex => _$this._failureSourceIndex;
  set failureSourceIndex(int? failureSourceIndex) =>
      _$this._failureSourceIndex = failureSourceIndex;

  int? _height;
  int? get height => _$this._height;
  set height(int? height) => _$this._height = height;

  HTLCAttemptFailureBuilder() {
    HTLCAttemptFailure._defaults(this);
  }

  HTLCAttemptFailureBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _channelUpdate = $v.channelUpdate.toBuilder();
      _htlcMsat = $v.htlcMsat;
      _onionSha256 = $v.onionSha256;
      _cltvExpiry = $v.cltvExpiry;
      _flags = $v.flags;
      _failureSourceIndex = $v.failureSourceIndex;
      _height = $v.height;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HTLCAttemptFailure other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$HTLCAttemptFailure;
  }

  @override
  void update(void Function(HTLCAttemptFailureBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HTLCAttemptFailure build() => _build();

  _$HTLCAttemptFailure _build() {
    _$HTLCAttemptFailure _$result;
    try {
      _$result = _$v ??
          _$HTLCAttemptFailure._(
              code: BuiltValueNullFieldError.checkNotNull(
                  code, r'HTLCAttemptFailure', 'code'),
              channelUpdate: channelUpdate.build(),
              htlcMsat: BuiltValueNullFieldError.checkNotNull(
                  htlcMsat, r'HTLCAttemptFailure', 'htlcMsat'),
              onionSha256: BuiltValueNullFieldError.checkNotNull(
                  onionSha256, r'HTLCAttemptFailure', 'onionSha256'),
              cltvExpiry: BuiltValueNullFieldError.checkNotNull(
                  cltvExpiry, r'HTLCAttemptFailure', 'cltvExpiry'),
              flags: BuiltValueNullFieldError.checkNotNull(
                  flags, r'HTLCAttemptFailure', 'flags'),
              failureSourceIndex: BuiltValueNullFieldError.checkNotNull(
                  failureSourceIndex,
                  r'HTLCAttemptFailure',
                  'failureSourceIndex'),
              height: BuiltValueNullFieldError.checkNotNull(
                  height, r'HTLCAttemptFailure', 'height'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'channelUpdate';
        channelUpdate.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'HTLCAttemptFailure', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
