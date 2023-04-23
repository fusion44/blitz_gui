// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ln_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LnInfo extends LnInfo {
  @override
  final String implementation;
  @override
  final String version;
  @override
  final String commitHash;
  @override
  final String? identityPubkey;
  @override
  final String? identityUri;
  @override
  final String alias;
  @override
  final String color;
  @override
  final int numPendingChannels;
  @override
  final int numActiveChannels;
  @override
  final int numInactiveChannels;
  @override
  final int numPeers;
  @override
  final int blockHeight;
  @override
  final String? blockHash;
  @override
  final int? bestHeaderTimestamp;
  @override
  final bool? syncedToChain;
  @override
  final bool? syncedToGraph;
  @override
  final BuiltList<Chain>? chains;
  @override
  final BuiltList<String>? uris;
  @override
  final BuiltList<FeaturesEntry>? features;

  factory _$LnInfo([void Function(LnInfoBuilder)? updates]) =>
      (LnInfoBuilder()..update(updates))._build();

  _$LnInfo._(
      {required this.implementation,
      required this.version,
      required this.commitHash,
      this.identityPubkey,
      this.identityUri,
      required this.alias,
      required this.color,
      required this.numPendingChannels,
      required this.numActiveChannels,
      required this.numInactiveChannels,
      required this.numPeers,
      required this.blockHeight,
      this.blockHash,
      this.bestHeaderTimestamp,
      this.syncedToChain,
      this.syncedToGraph,
      this.chains,
      this.uris,
      this.features})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        implementation, r'LnInfo', 'implementation');
    BuiltValueNullFieldError.checkNotNull(version, r'LnInfo', 'version');
    BuiltValueNullFieldError.checkNotNull(commitHash, r'LnInfo', 'commitHash');
    BuiltValueNullFieldError.checkNotNull(alias, r'LnInfo', 'alias');
    BuiltValueNullFieldError.checkNotNull(color, r'LnInfo', 'color');
    BuiltValueNullFieldError.checkNotNull(
        numPendingChannels, r'LnInfo', 'numPendingChannels');
    BuiltValueNullFieldError.checkNotNull(
        numActiveChannels, r'LnInfo', 'numActiveChannels');
    BuiltValueNullFieldError.checkNotNull(
        numInactiveChannels, r'LnInfo', 'numInactiveChannels');
    BuiltValueNullFieldError.checkNotNull(numPeers, r'LnInfo', 'numPeers');
    BuiltValueNullFieldError.checkNotNull(
        blockHeight, r'LnInfo', 'blockHeight');
  }

  @override
  LnInfo rebuild(void Function(LnInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LnInfoBuilder toBuilder() => LnInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LnInfo &&
        implementation == other.implementation &&
        version == other.version &&
        commitHash == other.commitHash &&
        identityPubkey == other.identityPubkey &&
        identityUri == other.identityUri &&
        alias == other.alias &&
        color == other.color &&
        numPendingChannels == other.numPendingChannels &&
        numActiveChannels == other.numActiveChannels &&
        numInactiveChannels == other.numInactiveChannels &&
        numPeers == other.numPeers &&
        blockHeight == other.blockHeight &&
        blockHash == other.blockHash &&
        bestHeaderTimestamp == other.bestHeaderTimestamp &&
        syncedToChain == other.syncedToChain &&
        syncedToGraph == other.syncedToGraph &&
        chains == other.chains &&
        uris == other.uris &&
        features == other.features;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, implementation.hashCode);
    _$hash = $jc(_$hash, version.hashCode);
    _$hash = $jc(_$hash, commitHash.hashCode);
    _$hash = $jc(_$hash, identityPubkey.hashCode);
    _$hash = $jc(_$hash, identityUri.hashCode);
    _$hash = $jc(_$hash, alias.hashCode);
    _$hash = $jc(_$hash, color.hashCode);
    _$hash = $jc(_$hash, numPendingChannels.hashCode);
    _$hash = $jc(_$hash, numActiveChannels.hashCode);
    _$hash = $jc(_$hash, numInactiveChannels.hashCode);
    _$hash = $jc(_$hash, numPeers.hashCode);
    _$hash = $jc(_$hash, blockHeight.hashCode);
    _$hash = $jc(_$hash, blockHash.hashCode);
    _$hash = $jc(_$hash, bestHeaderTimestamp.hashCode);
    _$hash = $jc(_$hash, syncedToChain.hashCode);
    _$hash = $jc(_$hash, syncedToGraph.hashCode);
    _$hash = $jc(_$hash, chains.hashCode);
    _$hash = $jc(_$hash, uris.hashCode);
    _$hash = $jc(_$hash, features.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LnInfo')
          ..add('implementation', implementation)
          ..add('version', version)
          ..add('commitHash', commitHash)
          ..add('identityPubkey', identityPubkey)
          ..add('identityUri', identityUri)
          ..add('alias', alias)
          ..add('color', color)
          ..add('numPendingChannels', numPendingChannels)
          ..add('numActiveChannels', numActiveChannels)
          ..add('numInactiveChannels', numInactiveChannels)
          ..add('numPeers', numPeers)
          ..add('blockHeight', blockHeight)
          ..add('blockHash', blockHash)
          ..add('bestHeaderTimestamp', bestHeaderTimestamp)
          ..add('syncedToChain', syncedToChain)
          ..add('syncedToGraph', syncedToGraph)
          ..add('chains', chains)
          ..add('uris', uris)
          ..add('features', features))
        .toString();
  }
}

class LnInfoBuilder implements Builder<LnInfo, LnInfoBuilder> {
  _$LnInfo? _$v;

  String? _implementation;
  String? get implementation => _$this._implementation;
  set implementation(String? implementation) =>
      _$this._implementation = implementation;

  String? _version;
  String? get version => _$this._version;
  set version(String? version) => _$this._version = version;

  String? _commitHash;
  String? get commitHash => _$this._commitHash;
  set commitHash(String? commitHash) => _$this._commitHash = commitHash;

  String? _identityPubkey;
  String? get identityPubkey => _$this._identityPubkey;
  set identityPubkey(String? identityPubkey) =>
      _$this._identityPubkey = identityPubkey;

  String? _identityUri;
  String? get identityUri => _$this._identityUri;
  set identityUri(String? identityUri) => _$this._identityUri = identityUri;

  String? _alias;
  String? get alias => _$this._alias;
  set alias(String? alias) => _$this._alias = alias;

  String? _color;
  String? get color => _$this._color;
  set color(String? color) => _$this._color = color;

  int? _numPendingChannels;
  int? get numPendingChannels => _$this._numPendingChannels;
  set numPendingChannels(int? numPendingChannels) =>
      _$this._numPendingChannels = numPendingChannels;

  int? _numActiveChannels;
  int? get numActiveChannels => _$this._numActiveChannels;
  set numActiveChannels(int? numActiveChannels) =>
      _$this._numActiveChannels = numActiveChannels;

  int? _numInactiveChannels;
  int? get numInactiveChannels => _$this._numInactiveChannels;
  set numInactiveChannels(int? numInactiveChannels) =>
      _$this._numInactiveChannels = numInactiveChannels;

  int? _numPeers;
  int? get numPeers => _$this._numPeers;
  set numPeers(int? numPeers) => _$this._numPeers = numPeers;

  int? _blockHeight;
  int? get blockHeight => _$this._blockHeight;
  set blockHeight(int? blockHeight) => _$this._blockHeight = blockHeight;

  String? _blockHash;
  String? get blockHash => _$this._blockHash;
  set blockHash(String? blockHash) => _$this._blockHash = blockHash;

  int? _bestHeaderTimestamp;
  int? get bestHeaderTimestamp => _$this._bestHeaderTimestamp;
  set bestHeaderTimestamp(int? bestHeaderTimestamp) =>
      _$this._bestHeaderTimestamp = bestHeaderTimestamp;

  bool? _syncedToChain;
  bool? get syncedToChain => _$this._syncedToChain;
  set syncedToChain(bool? syncedToChain) =>
      _$this._syncedToChain = syncedToChain;

  bool? _syncedToGraph;
  bool? get syncedToGraph => _$this._syncedToGraph;
  set syncedToGraph(bool? syncedToGraph) =>
      _$this._syncedToGraph = syncedToGraph;

  ListBuilder<Chain>? _chains;
  ListBuilder<Chain> get chains => _$this._chains ??= ListBuilder<Chain>();
  set chains(ListBuilder<Chain>? chains) => _$this._chains = chains;

  ListBuilder<String>? _uris;
  ListBuilder<String> get uris => _$this._uris ??= ListBuilder<String>();
  set uris(ListBuilder<String>? uris) => _$this._uris = uris;

  ListBuilder<FeaturesEntry>? _features;
  ListBuilder<FeaturesEntry> get features =>
      _$this._features ??= ListBuilder<FeaturesEntry>();
  set features(ListBuilder<FeaturesEntry>? features) =>
      _$this._features = features;

  LnInfoBuilder() {
    LnInfo._defaults(this);
  }

  LnInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _implementation = $v.implementation;
      _version = $v.version;
      _commitHash = $v.commitHash;
      _identityPubkey = $v.identityPubkey;
      _identityUri = $v.identityUri;
      _alias = $v.alias;
      _color = $v.color;
      _numPendingChannels = $v.numPendingChannels;
      _numActiveChannels = $v.numActiveChannels;
      _numInactiveChannels = $v.numInactiveChannels;
      _numPeers = $v.numPeers;
      _blockHeight = $v.blockHeight;
      _blockHash = $v.blockHash;
      _bestHeaderTimestamp = $v.bestHeaderTimestamp;
      _syncedToChain = $v.syncedToChain;
      _syncedToGraph = $v.syncedToGraph;
      _chains = $v.chains?.toBuilder();
      _uris = $v.uris?.toBuilder();
      _features = $v.features?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LnInfo other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$LnInfo;
  }

  @override
  void update(void Function(LnInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LnInfo build() => _build();

  _$LnInfo _build() {
    _$LnInfo _$result;
    try {
      _$result = _$v ??
          _$LnInfo._(
              implementation: BuiltValueNullFieldError.checkNotNull(
                  implementation, r'LnInfo', 'implementation'),
              version: BuiltValueNullFieldError.checkNotNull(
                  version, r'LnInfo', 'version'),
              commitHash: BuiltValueNullFieldError.checkNotNull(
                  commitHash, r'LnInfo', 'commitHash'),
              identityPubkey: identityPubkey,
              identityUri: identityUri,
              alias: BuiltValueNullFieldError.checkNotNull(
                  alias, r'LnInfo', 'alias'),
              color: BuiltValueNullFieldError.checkNotNull(
                  color, r'LnInfo', 'color'),
              numPendingChannels: BuiltValueNullFieldError.checkNotNull(
                  numPendingChannels, r'LnInfo', 'numPendingChannels'),
              numActiveChannels: BuiltValueNullFieldError.checkNotNull(
                  numActiveChannels, r'LnInfo', 'numActiveChannels'),
              numInactiveChannels: BuiltValueNullFieldError.checkNotNull(
                  numInactiveChannels, r'LnInfo', 'numInactiveChannels'),
              numPeers: BuiltValueNullFieldError.checkNotNull(
                  numPeers, r'LnInfo', 'numPeers'),
              blockHeight: BuiltValueNullFieldError.checkNotNull(blockHeight, r'LnInfo', 'blockHeight'),
              blockHash: blockHash,
              bestHeaderTimestamp: bestHeaderTimestamp,
              syncedToChain: syncedToChain,
              syncedToGraph: syncedToGraph,
              chains: _chains?.build(),
              uris: _uris?.build(),
              features: _features?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'chains';
        _chains?.build();
        _$failedField = 'uris';
        _uris?.build();
        _$failedField = 'features';
        _features?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'LnInfo', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
