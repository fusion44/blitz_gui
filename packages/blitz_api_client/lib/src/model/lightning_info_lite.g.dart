// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lightning_info_lite.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LightningInfoLite extends LightningInfoLite {
  @override
  final String implementation;
  @override
  final String version;
  @override
  final String identityPubkey;
  @override
  final String identityUri;
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
  final bool? syncedToChain;
  @override
  final bool? syncedToGraph;

  factory _$LightningInfoLite(
          [void Function(LightningInfoLiteBuilder)? updates]) =>
      (LightningInfoLiteBuilder()..update(updates))._build();

  _$LightningInfoLite._(
      {required this.implementation,
      required this.version,
      required this.identityPubkey,
      required this.identityUri,
      required this.numPendingChannels,
      required this.numActiveChannels,
      required this.numInactiveChannels,
      required this.numPeers,
      required this.blockHeight,
      this.syncedToChain,
      this.syncedToGraph})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        implementation, r'LightningInfoLite', 'implementation');
    BuiltValueNullFieldError.checkNotNull(
        version, r'LightningInfoLite', 'version');
    BuiltValueNullFieldError.checkNotNull(
        identityPubkey, r'LightningInfoLite', 'identityPubkey');
    BuiltValueNullFieldError.checkNotNull(
        identityUri, r'LightningInfoLite', 'identityUri');
    BuiltValueNullFieldError.checkNotNull(
        numPendingChannels, r'LightningInfoLite', 'numPendingChannels');
    BuiltValueNullFieldError.checkNotNull(
        numActiveChannels, r'LightningInfoLite', 'numActiveChannels');
    BuiltValueNullFieldError.checkNotNull(
        numInactiveChannels, r'LightningInfoLite', 'numInactiveChannels');
    BuiltValueNullFieldError.checkNotNull(
        numPeers, r'LightningInfoLite', 'numPeers');
    BuiltValueNullFieldError.checkNotNull(
        blockHeight, r'LightningInfoLite', 'blockHeight');
  }

  @override
  LightningInfoLite rebuild(void Function(LightningInfoLiteBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LightningInfoLiteBuilder toBuilder() =>
      LightningInfoLiteBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LightningInfoLite &&
        implementation == other.implementation &&
        version == other.version &&
        identityPubkey == other.identityPubkey &&
        identityUri == other.identityUri &&
        numPendingChannels == other.numPendingChannels &&
        numActiveChannels == other.numActiveChannels &&
        numInactiveChannels == other.numInactiveChannels &&
        numPeers == other.numPeers &&
        blockHeight == other.blockHeight &&
        syncedToChain == other.syncedToChain &&
        syncedToGraph == other.syncedToGraph;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, implementation.hashCode);
    _$hash = $jc(_$hash, version.hashCode);
    _$hash = $jc(_$hash, identityPubkey.hashCode);
    _$hash = $jc(_$hash, identityUri.hashCode);
    _$hash = $jc(_$hash, numPendingChannels.hashCode);
    _$hash = $jc(_$hash, numActiveChannels.hashCode);
    _$hash = $jc(_$hash, numInactiveChannels.hashCode);
    _$hash = $jc(_$hash, numPeers.hashCode);
    _$hash = $jc(_$hash, blockHeight.hashCode);
    _$hash = $jc(_$hash, syncedToChain.hashCode);
    _$hash = $jc(_$hash, syncedToGraph.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LightningInfoLite')
          ..add('implementation', implementation)
          ..add('version', version)
          ..add('identityPubkey', identityPubkey)
          ..add('identityUri', identityUri)
          ..add('numPendingChannels', numPendingChannels)
          ..add('numActiveChannels', numActiveChannels)
          ..add('numInactiveChannels', numInactiveChannels)
          ..add('numPeers', numPeers)
          ..add('blockHeight', blockHeight)
          ..add('syncedToChain', syncedToChain)
          ..add('syncedToGraph', syncedToGraph))
        .toString();
  }
}

class LightningInfoLiteBuilder
    implements Builder<LightningInfoLite, LightningInfoLiteBuilder> {
  _$LightningInfoLite? _$v;

  String? _implementation;
  String? get implementation => _$this._implementation;
  set implementation(String? implementation) =>
      _$this._implementation = implementation;

  String? _version;
  String? get version => _$this._version;
  set version(String? version) => _$this._version = version;

  String? _identityPubkey;
  String? get identityPubkey => _$this._identityPubkey;
  set identityPubkey(String? identityPubkey) =>
      _$this._identityPubkey = identityPubkey;

  String? _identityUri;
  String? get identityUri => _$this._identityUri;
  set identityUri(String? identityUri) => _$this._identityUri = identityUri;

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

  bool? _syncedToChain;
  bool? get syncedToChain => _$this._syncedToChain;
  set syncedToChain(bool? syncedToChain) =>
      _$this._syncedToChain = syncedToChain;

  bool? _syncedToGraph;
  bool? get syncedToGraph => _$this._syncedToGraph;
  set syncedToGraph(bool? syncedToGraph) =>
      _$this._syncedToGraph = syncedToGraph;

  LightningInfoLiteBuilder() {
    LightningInfoLite._defaults(this);
  }

  LightningInfoLiteBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _implementation = $v.implementation;
      _version = $v.version;
      _identityPubkey = $v.identityPubkey;
      _identityUri = $v.identityUri;
      _numPendingChannels = $v.numPendingChannels;
      _numActiveChannels = $v.numActiveChannels;
      _numInactiveChannels = $v.numInactiveChannels;
      _numPeers = $v.numPeers;
      _blockHeight = $v.blockHeight;
      _syncedToChain = $v.syncedToChain;
      _syncedToGraph = $v.syncedToGraph;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LightningInfoLite other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$LightningInfoLite;
  }

  @override
  void update(void Function(LightningInfoLiteBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LightningInfoLite build() => _build();

  _$LightningInfoLite _build() {
    final _$result = _$v ??
        _$LightningInfoLite._(
            implementation: BuiltValueNullFieldError.checkNotNull(
                implementation, r'LightningInfoLite', 'implementation'),
            version: BuiltValueNullFieldError.checkNotNull(
                version, r'LightningInfoLite', 'version'),
            identityPubkey: BuiltValueNullFieldError.checkNotNull(
                identityPubkey, r'LightningInfoLite', 'identityPubkey'),
            identityUri: BuiltValueNullFieldError.checkNotNull(
                identityUri, r'LightningInfoLite', 'identityUri'),
            numPendingChannels: BuiltValueNullFieldError.checkNotNull(
                numPendingChannels, r'LightningInfoLite', 'numPendingChannels'),
            numActiveChannels: BuiltValueNullFieldError.checkNotNull(
                numActiveChannels, r'LightningInfoLite', 'numActiveChannels'),
            numInactiveChannels: BuiltValueNullFieldError.checkNotNull(
                numInactiveChannels, r'LightningInfoLite', 'numInactiveChannels'),
            numPeers:
                BuiltValueNullFieldError.checkNotNull(numPeers, r'LightningInfoLite', 'numPeers'),
            blockHeight: BuiltValueNullFieldError.checkNotNull(blockHeight, r'LightningInfoLite', 'blockHeight'),
            syncedToChain: syncedToChain,
            syncedToGraph: syncedToGraph);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
