// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'btc_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BtcInfo extends BtcInfo {
  @override
  final int blocks;
  @override
  final int headers;
  @override
  final num verificationProgress;
  @override
  final int difficulty;
  @override
  final int sizeOnDisk;
  @override
  final BuiltList<BtcNetwork>? networks;
  @override
  final int version;
  @override
  final String subversion;
  @override
  final int connectionsIn;
  @override
  final int connectionsOut;

  factory _$BtcInfo([void Function(BtcInfoBuilder)? updates]) =>
      (BtcInfoBuilder()..update(updates))._build();

  _$BtcInfo._(
      {required this.blocks,
      required this.headers,
      required this.verificationProgress,
      required this.difficulty,
      required this.sizeOnDisk,
      this.networks,
      required this.version,
      required this.subversion,
      required this.connectionsIn,
      required this.connectionsOut})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(blocks, r'BtcInfo', 'blocks');
    BuiltValueNullFieldError.checkNotNull(headers, r'BtcInfo', 'headers');
    BuiltValueNullFieldError.checkNotNull(
        verificationProgress, r'BtcInfo', 'verificationProgress');
    BuiltValueNullFieldError.checkNotNull(difficulty, r'BtcInfo', 'difficulty');
    BuiltValueNullFieldError.checkNotNull(sizeOnDisk, r'BtcInfo', 'sizeOnDisk');
    BuiltValueNullFieldError.checkNotNull(version, r'BtcInfo', 'version');
    BuiltValueNullFieldError.checkNotNull(subversion, r'BtcInfo', 'subversion');
    BuiltValueNullFieldError.checkNotNull(
        connectionsIn, r'BtcInfo', 'connectionsIn');
    BuiltValueNullFieldError.checkNotNull(
        connectionsOut, r'BtcInfo', 'connectionsOut');
  }

  @override
  BtcInfo rebuild(void Function(BtcInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BtcInfoBuilder toBuilder() => BtcInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BtcInfo &&
        blocks == other.blocks &&
        headers == other.headers &&
        verificationProgress == other.verificationProgress &&
        difficulty == other.difficulty &&
        sizeOnDisk == other.sizeOnDisk &&
        networks == other.networks &&
        version == other.version &&
        subversion == other.subversion &&
        connectionsIn == other.connectionsIn &&
        connectionsOut == other.connectionsOut;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, blocks.hashCode);
    _$hash = $jc(_$hash, headers.hashCode);
    _$hash = $jc(_$hash, verificationProgress.hashCode);
    _$hash = $jc(_$hash, difficulty.hashCode);
    _$hash = $jc(_$hash, sizeOnDisk.hashCode);
    _$hash = $jc(_$hash, networks.hashCode);
    _$hash = $jc(_$hash, version.hashCode);
    _$hash = $jc(_$hash, subversion.hashCode);
    _$hash = $jc(_$hash, connectionsIn.hashCode);
    _$hash = $jc(_$hash, connectionsOut.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BtcInfo')
          ..add('blocks', blocks)
          ..add('headers', headers)
          ..add('verificationProgress', verificationProgress)
          ..add('difficulty', difficulty)
          ..add('sizeOnDisk', sizeOnDisk)
          ..add('networks', networks)
          ..add('version', version)
          ..add('subversion', subversion)
          ..add('connectionsIn', connectionsIn)
          ..add('connectionsOut', connectionsOut))
        .toString();
  }
}

class BtcInfoBuilder implements Builder<BtcInfo, BtcInfoBuilder> {
  _$BtcInfo? _$v;

  int? _blocks;
  int? get blocks => _$this._blocks;
  set blocks(int? blocks) => _$this._blocks = blocks;

  int? _headers;
  int? get headers => _$this._headers;
  set headers(int? headers) => _$this._headers = headers;

  num? _verificationProgress;
  num? get verificationProgress => _$this._verificationProgress;
  set verificationProgress(num? verificationProgress) =>
      _$this._verificationProgress = verificationProgress;

  int? _difficulty;
  int? get difficulty => _$this._difficulty;
  set difficulty(int? difficulty) => _$this._difficulty = difficulty;

  int? _sizeOnDisk;
  int? get sizeOnDisk => _$this._sizeOnDisk;
  set sizeOnDisk(int? sizeOnDisk) => _$this._sizeOnDisk = sizeOnDisk;

  ListBuilder<BtcNetwork>? _networks;
  ListBuilder<BtcNetwork> get networks =>
      _$this._networks ??= ListBuilder<BtcNetwork>();
  set networks(ListBuilder<BtcNetwork>? networks) =>
      _$this._networks = networks;

  int? _version;
  int? get version => _$this._version;
  set version(int? version) => _$this._version = version;

  String? _subversion;
  String? get subversion => _$this._subversion;
  set subversion(String? subversion) => _$this._subversion = subversion;

  int? _connectionsIn;
  int? get connectionsIn => _$this._connectionsIn;
  set connectionsIn(int? connectionsIn) =>
      _$this._connectionsIn = connectionsIn;

  int? _connectionsOut;
  int? get connectionsOut => _$this._connectionsOut;
  set connectionsOut(int? connectionsOut) =>
      _$this._connectionsOut = connectionsOut;

  BtcInfoBuilder() {
    BtcInfo._defaults(this);
  }

  BtcInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _blocks = $v.blocks;
      _headers = $v.headers;
      _verificationProgress = $v.verificationProgress;
      _difficulty = $v.difficulty;
      _sizeOnDisk = $v.sizeOnDisk;
      _networks = $v.networks?.toBuilder();
      _version = $v.version;
      _subversion = $v.subversion;
      _connectionsIn = $v.connectionsIn;
      _connectionsOut = $v.connectionsOut;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BtcInfo other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$BtcInfo;
  }

  @override
  void update(void Function(BtcInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BtcInfo build() => _build();

  _$BtcInfo _build() {
    _$BtcInfo _$result;
    try {
      _$result = _$v ??
          _$BtcInfo._(
              blocks: BuiltValueNullFieldError.checkNotNull(
                  blocks, r'BtcInfo', 'blocks'),
              headers: BuiltValueNullFieldError.checkNotNull(
                  headers, r'BtcInfo', 'headers'),
              verificationProgress: BuiltValueNullFieldError.checkNotNull(
                  verificationProgress, r'BtcInfo', 'verificationProgress'),
              difficulty: BuiltValueNullFieldError.checkNotNull(
                  difficulty, r'BtcInfo', 'difficulty'),
              sizeOnDisk: BuiltValueNullFieldError.checkNotNull(
                  sizeOnDisk, r'BtcInfo', 'sizeOnDisk'),
              networks: _networks?.build(),
              version: BuiltValueNullFieldError.checkNotNull(
                  version, r'BtcInfo', 'version'),
              subversion: BuiltValueNullFieldError.checkNotNull(
                  subversion, r'BtcInfo', 'subversion'),
              connectionsIn: BuiltValueNullFieldError.checkNotNull(
                  connectionsIn, r'BtcInfo', 'connectionsIn'),
              connectionsOut:
                  BuiltValueNullFieldError.checkNotNull(connectionsOut, r'BtcInfo', 'connectionsOut'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'networks';
        _networks?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'BtcInfo', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
