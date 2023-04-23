// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NetworkInfo extends NetworkInfo {
  @override
  final int version;
  @override
  final String subversion;
  @override
  final int protocolVersion;
  @override
  final String? localServices;
  @override
  final BuiltList<String>? localServicesNames;
  @override
  final bool localRelay;
  @override
  final int timeOffset;
  @override
  final int connections;
  @override
  final int connectionsIn;
  @override
  final int connectionsOut;
  @override
  final bool networkActive;
  @override
  final BuiltList<BtcNetwork> networks;
  @override
  final int relayFee;
  @override
  final int incrementalFee;
  @override
  final BuiltList<BtcLocalAddress>? localAddresses;
  @override
  final String? warnings;

  factory _$NetworkInfo([void Function(NetworkInfoBuilder)? updates]) =>
      (NetworkInfoBuilder()..update(updates))._build();

  _$NetworkInfo._(
      {required this.version,
      required this.subversion,
      required this.protocolVersion,
      this.localServices,
      this.localServicesNames,
      required this.localRelay,
      required this.timeOffset,
      required this.connections,
      required this.connectionsIn,
      required this.connectionsOut,
      required this.networkActive,
      required this.networks,
      required this.relayFee,
      required this.incrementalFee,
      this.localAddresses,
      this.warnings})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(version, r'NetworkInfo', 'version');
    BuiltValueNullFieldError.checkNotNull(
        subversion, r'NetworkInfo', 'subversion');
    BuiltValueNullFieldError.checkNotNull(
        protocolVersion, r'NetworkInfo', 'protocolVersion');
    BuiltValueNullFieldError.checkNotNull(
        localRelay, r'NetworkInfo', 'localRelay');
    BuiltValueNullFieldError.checkNotNull(
        timeOffset, r'NetworkInfo', 'timeOffset');
    BuiltValueNullFieldError.checkNotNull(
        connections, r'NetworkInfo', 'connections');
    BuiltValueNullFieldError.checkNotNull(
        connectionsIn, r'NetworkInfo', 'connectionsIn');
    BuiltValueNullFieldError.checkNotNull(
        connectionsOut, r'NetworkInfo', 'connectionsOut');
    BuiltValueNullFieldError.checkNotNull(
        networkActive, r'NetworkInfo', 'networkActive');
    BuiltValueNullFieldError.checkNotNull(networks, r'NetworkInfo', 'networks');
    BuiltValueNullFieldError.checkNotNull(relayFee, r'NetworkInfo', 'relayFee');
    BuiltValueNullFieldError.checkNotNull(
        incrementalFee, r'NetworkInfo', 'incrementalFee');
  }

  @override
  NetworkInfo rebuild(void Function(NetworkInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NetworkInfoBuilder toBuilder() => NetworkInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NetworkInfo &&
        version == other.version &&
        subversion == other.subversion &&
        protocolVersion == other.protocolVersion &&
        localServices == other.localServices &&
        localServicesNames == other.localServicesNames &&
        localRelay == other.localRelay &&
        timeOffset == other.timeOffset &&
        connections == other.connections &&
        connectionsIn == other.connectionsIn &&
        connectionsOut == other.connectionsOut &&
        networkActive == other.networkActive &&
        networks == other.networks &&
        relayFee == other.relayFee &&
        incrementalFee == other.incrementalFee &&
        localAddresses == other.localAddresses &&
        warnings == other.warnings;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, version.hashCode);
    _$hash = $jc(_$hash, subversion.hashCode);
    _$hash = $jc(_$hash, protocolVersion.hashCode);
    _$hash = $jc(_$hash, localServices.hashCode);
    _$hash = $jc(_$hash, localServicesNames.hashCode);
    _$hash = $jc(_$hash, localRelay.hashCode);
    _$hash = $jc(_$hash, timeOffset.hashCode);
    _$hash = $jc(_$hash, connections.hashCode);
    _$hash = $jc(_$hash, connectionsIn.hashCode);
    _$hash = $jc(_$hash, connectionsOut.hashCode);
    _$hash = $jc(_$hash, networkActive.hashCode);
    _$hash = $jc(_$hash, networks.hashCode);
    _$hash = $jc(_$hash, relayFee.hashCode);
    _$hash = $jc(_$hash, incrementalFee.hashCode);
    _$hash = $jc(_$hash, localAddresses.hashCode);
    _$hash = $jc(_$hash, warnings.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NetworkInfo')
          ..add('version', version)
          ..add('subversion', subversion)
          ..add('protocolVersion', protocolVersion)
          ..add('localServices', localServices)
          ..add('localServicesNames', localServicesNames)
          ..add('localRelay', localRelay)
          ..add('timeOffset', timeOffset)
          ..add('connections', connections)
          ..add('connectionsIn', connectionsIn)
          ..add('connectionsOut', connectionsOut)
          ..add('networkActive', networkActive)
          ..add('networks', networks)
          ..add('relayFee', relayFee)
          ..add('incrementalFee', incrementalFee)
          ..add('localAddresses', localAddresses)
          ..add('warnings', warnings))
        .toString();
  }
}

class NetworkInfoBuilder implements Builder<NetworkInfo, NetworkInfoBuilder> {
  _$NetworkInfo? _$v;

  int? _version;
  int? get version => _$this._version;
  set version(int? version) => _$this._version = version;

  String? _subversion;
  String? get subversion => _$this._subversion;
  set subversion(String? subversion) => _$this._subversion = subversion;

  int? _protocolVersion;
  int? get protocolVersion => _$this._protocolVersion;
  set protocolVersion(int? protocolVersion) =>
      _$this._protocolVersion = protocolVersion;

  String? _localServices;
  String? get localServices => _$this._localServices;
  set localServices(String? localServices) =>
      _$this._localServices = localServices;

  ListBuilder<String>? _localServicesNames;
  ListBuilder<String> get localServicesNames =>
      _$this._localServicesNames ??= ListBuilder<String>();
  set localServicesNames(ListBuilder<String>? localServicesNames) =>
      _$this._localServicesNames = localServicesNames;

  bool? _localRelay;
  bool? get localRelay => _$this._localRelay;
  set localRelay(bool? localRelay) => _$this._localRelay = localRelay;

  int? _timeOffset;
  int? get timeOffset => _$this._timeOffset;
  set timeOffset(int? timeOffset) => _$this._timeOffset = timeOffset;

  int? _connections;
  int? get connections => _$this._connections;
  set connections(int? connections) => _$this._connections = connections;

  int? _connectionsIn;
  int? get connectionsIn => _$this._connectionsIn;
  set connectionsIn(int? connectionsIn) =>
      _$this._connectionsIn = connectionsIn;

  int? _connectionsOut;
  int? get connectionsOut => _$this._connectionsOut;
  set connectionsOut(int? connectionsOut) =>
      _$this._connectionsOut = connectionsOut;

  bool? _networkActive;
  bool? get networkActive => _$this._networkActive;
  set networkActive(bool? networkActive) =>
      _$this._networkActive = networkActive;

  ListBuilder<BtcNetwork>? _networks;
  ListBuilder<BtcNetwork> get networks =>
      _$this._networks ??= ListBuilder<BtcNetwork>();
  set networks(ListBuilder<BtcNetwork>? networks) =>
      _$this._networks = networks;

  int? _relayFee;
  int? get relayFee => _$this._relayFee;
  set relayFee(int? relayFee) => _$this._relayFee = relayFee;

  int? _incrementalFee;
  int? get incrementalFee => _$this._incrementalFee;
  set incrementalFee(int? incrementalFee) =>
      _$this._incrementalFee = incrementalFee;

  ListBuilder<BtcLocalAddress>? _localAddresses;
  ListBuilder<BtcLocalAddress> get localAddresses =>
      _$this._localAddresses ??= ListBuilder<BtcLocalAddress>();
  set localAddresses(ListBuilder<BtcLocalAddress>? localAddresses) =>
      _$this._localAddresses = localAddresses;

  String? _warnings;
  String? get warnings => _$this._warnings;
  set warnings(String? warnings) => _$this._warnings = warnings;

  NetworkInfoBuilder() {
    NetworkInfo._defaults(this);
  }

  NetworkInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _version = $v.version;
      _subversion = $v.subversion;
      _protocolVersion = $v.protocolVersion;
      _localServices = $v.localServices;
      _localServicesNames = $v.localServicesNames?.toBuilder();
      _localRelay = $v.localRelay;
      _timeOffset = $v.timeOffset;
      _connections = $v.connections;
      _connectionsIn = $v.connectionsIn;
      _connectionsOut = $v.connectionsOut;
      _networkActive = $v.networkActive;
      _networks = $v.networks.toBuilder();
      _relayFee = $v.relayFee;
      _incrementalFee = $v.incrementalFee;
      _localAddresses = $v.localAddresses?.toBuilder();
      _warnings = $v.warnings;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NetworkInfo other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$NetworkInfo;
  }

  @override
  void update(void Function(NetworkInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NetworkInfo build() => _build();

  _$NetworkInfo _build() {
    _$NetworkInfo _$result;
    try {
      _$result = _$v ??
          _$NetworkInfo._(
              version: BuiltValueNullFieldError.checkNotNull(
                  version, r'NetworkInfo', 'version'),
              subversion: BuiltValueNullFieldError.checkNotNull(
                  subversion, r'NetworkInfo', 'subversion'),
              protocolVersion: BuiltValueNullFieldError.checkNotNull(
                  protocolVersion, r'NetworkInfo', 'protocolVersion'),
              localServices: localServices,
              localServicesNames: _localServicesNames?.build(),
              localRelay: BuiltValueNullFieldError.checkNotNull(
                  localRelay, r'NetworkInfo', 'localRelay'),
              timeOffset: BuiltValueNullFieldError.checkNotNull(
                  timeOffset, r'NetworkInfo', 'timeOffset'),
              connections: BuiltValueNullFieldError.checkNotNull(
                  connections, r'NetworkInfo', 'connections'),
              connectionsIn: BuiltValueNullFieldError.checkNotNull(
                  connectionsIn, r'NetworkInfo', 'connectionsIn'),
              connectionsOut: BuiltValueNullFieldError.checkNotNull(
                  connectionsOut, r'NetworkInfo', 'connectionsOut'),
              networkActive: BuiltValueNullFieldError.checkNotNull(networkActive, r'NetworkInfo', 'networkActive'),
              networks: networks.build(),
              relayFee: BuiltValueNullFieldError.checkNotNull(relayFee, r'NetworkInfo', 'relayFee'),
              incrementalFee: BuiltValueNullFieldError.checkNotNull(incrementalFee, r'NetworkInfo', 'incrementalFee'),
              localAddresses: _localAddresses?.build(),
              warnings: warnings);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'localServicesNames';
        _localServicesNames?.build();

        _$failedField = 'networks';
        networks.build();

        _$failedField = 'localAddresses';
        _localAddresses?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'NetworkInfo', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
