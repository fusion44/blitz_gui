// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SystemInfo extends SystemInfo {
  @override
  final String? alias;
  @override
  final String color;
  @override
  final APIPlatform? platform;
  @override
  final String? platformVersion;
  @override
  final String apiVersion;
  @override
  final String? torWebUi;
  @override
  final String? torApi;
  @override
  final String? lanWebUi;
  @override
  final String? lanApi;
  @override
  final String sshAddress;
  @override
  final String chain;
  @override
  final String? codeVersion;

  factory _$SystemInfo([void Function(SystemInfoBuilder)? updates]) =>
      (SystemInfoBuilder()..update(updates))._build();

  _$SystemInfo._(
      {this.alias,
      required this.color,
      this.platform,
      this.platformVersion,
      required this.apiVersion,
      this.torWebUi,
      this.torApi,
      this.lanWebUi,
      this.lanApi,
      required this.sshAddress,
      required this.chain,
      this.codeVersion})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(color, r'SystemInfo', 'color');
    BuiltValueNullFieldError.checkNotNull(
        apiVersion, r'SystemInfo', 'apiVersion');
    BuiltValueNullFieldError.checkNotNull(
        sshAddress, r'SystemInfo', 'sshAddress');
    BuiltValueNullFieldError.checkNotNull(chain, r'SystemInfo', 'chain');
  }

  @override
  SystemInfo rebuild(void Function(SystemInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SystemInfoBuilder toBuilder() => SystemInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SystemInfo &&
        alias == other.alias &&
        color == other.color &&
        platform == other.platform &&
        platformVersion == other.platformVersion &&
        apiVersion == other.apiVersion &&
        torWebUi == other.torWebUi &&
        torApi == other.torApi &&
        lanWebUi == other.lanWebUi &&
        lanApi == other.lanApi &&
        sshAddress == other.sshAddress &&
        chain == other.chain &&
        codeVersion == other.codeVersion;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, alias.hashCode);
    _$hash = $jc(_$hash, color.hashCode);
    _$hash = $jc(_$hash, platform.hashCode);
    _$hash = $jc(_$hash, platformVersion.hashCode);
    _$hash = $jc(_$hash, apiVersion.hashCode);
    _$hash = $jc(_$hash, torWebUi.hashCode);
    _$hash = $jc(_$hash, torApi.hashCode);
    _$hash = $jc(_$hash, lanWebUi.hashCode);
    _$hash = $jc(_$hash, lanApi.hashCode);
    _$hash = $jc(_$hash, sshAddress.hashCode);
    _$hash = $jc(_$hash, chain.hashCode);
    _$hash = $jc(_$hash, codeVersion.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SystemInfo')
          ..add('alias', alias)
          ..add('color', color)
          ..add('platform', platform)
          ..add('platformVersion', platformVersion)
          ..add('apiVersion', apiVersion)
          ..add('torWebUi', torWebUi)
          ..add('torApi', torApi)
          ..add('lanWebUi', lanWebUi)
          ..add('lanApi', lanApi)
          ..add('sshAddress', sshAddress)
          ..add('chain', chain)
          ..add('codeVersion', codeVersion))
        .toString();
  }
}

class SystemInfoBuilder implements Builder<SystemInfo, SystemInfoBuilder> {
  _$SystemInfo? _$v;

  String? _alias;
  String? get alias => _$this._alias;
  set alias(String? alias) => _$this._alias = alias;

  String? _color;
  String? get color => _$this._color;
  set color(String? color) => _$this._color = color;

  APIPlatform? _platform;
  APIPlatform? get platform => _$this._platform;
  set platform(APIPlatform? platform) => _$this._platform = platform;

  String? _platformVersion;
  String? get platformVersion => _$this._platformVersion;
  set platformVersion(String? platformVersion) =>
      _$this._platformVersion = platformVersion;

  String? _apiVersion;
  String? get apiVersion => _$this._apiVersion;
  set apiVersion(String? apiVersion) => _$this._apiVersion = apiVersion;

  String? _torWebUi;
  String? get torWebUi => _$this._torWebUi;
  set torWebUi(String? torWebUi) => _$this._torWebUi = torWebUi;

  String? _torApi;
  String? get torApi => _$this._torApi;
  set torApi(String? torApi) => _$this._torApi = torApi;

  String? _lanWebUi;
  String? get lanWebUi => _$this._lanWebUi;
  set lanWebUi(String? lanWebUi) => _$this._lanWebUi = lanWebUi;

  String? _lanApi;
  String? get lanApi => _$this._lanApi;
  set lanApi(String? lanApi) => _$this._lanApi = lanApi;

  String? _sshAddress;
  String? get sshAddress => _$this._sshAddress;
  set sshAddress(String? sshAddress) => _$this._sshAddress = sshAddress;

  String? _chain;
  String? get chain => _$this._chain;
  set chain(String? chain) => _$this._chain = chain;

  String? _codeVersion;
  String? get codeVersion => _$this._codeVersion;
  set codeVersion(String? codeVersion) => _$this._codeVersion = codeVersion;

  SystemInfoBuilder() {
    SystemInfo._defaults(this);
  }

  SystemInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _alias = $v.alias;
      _color = $v.color;
      _platform = $v.platform;
      _platformVersion = $v.platformVersion;
      _apiVersion = $v.apiVersion;
      _torWebUi = $v.torWebUi;
      _torApi = $v.torApi;
      _lanWebUi = $v.lanWebUi;
      _lanApi = $v.lanApi;
      _sshAddress = $v.sshAddress;
      _chain = $v.chain;
      _codeVersion = $v.codeVersion;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SystemInfo other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SystemInfo;
  }

  @override
  void update(void Function(SystemInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SystemInfo build() => _build();

  _$SystemInfo _build() {
    final _$result = _$v ??
        _$SystemInfo._(
            alias: alias,
            color: BuiltValueNullFieldError.checkNotNull(
                color, r'SystemInfo', 'color'),
            platform: platform,
            platformVersion: platformVersion,
            apiVersion: BuiltValueNullFieldError.checkNotNull(
                apiVersion, r'SystemInfo', 'apiVersion'),
            torWebUi: torWebUi,
            torApi: torApi,
            lanWebUi: lanWebUi,
            lanApi: lanApi,
            sshAddress: BuiltValueNullFieldError.checkNotNull(
                sshAddress, r'SystemInfo', 'sshAddress'),
            chain: BuiltValueNullFieldError.checkNotNull(
                chain, r'SystemInfo', 'chain'),
            codeVersion: codeVersion);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
