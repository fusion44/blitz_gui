// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blockchain_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BlockchainInfo extends BlockchainInfo {
  @override
  final String chain;
  @override
  final int blocks;
  @override
  final int headers;
  @override
  final String bestBlockHash;
  @override
  final int difficulty;
  @override
  final int mediantime;
  @override
  final num verificationProgress;
  @override
  final bool initialBlockDownload;
  @override
  final String chainwork;
  @override
  final int sizeOnDisk;
  @override
  final bool pruned;
  @override
  final int? pruneHeight;
  @override
  final bool? automaticPruning;
  @override
  final int? pruneTargetSize;
  @override
  final String warnings;
  @override
  final BuiltList<SoftFork> softforks;

  factory _$BlockchainInfo([void Function(BlockchainInfoBuilder)? updates]) =>
      (BlockchainInfoBuilder()..update(updates))._build();

  _$BlockchainInfo._(
      {required this.chain,
      required this.blocks,
      required this.headers,
      required this.bestBlockHash,
      required this.difficulty,
      required this.mediantime,
      required this.verificationProgress,
      required this.initialBlockDownload,
      required this.chainwork,
      required this.sizeOnDisk,
      required this.pruned,
      this.pruneHeight,
      this.automaticPruning,
      this.pruneTargetSize,
      required this.warnings,
      required this.softforks})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(chain, r'BlockchainInfo', 'chain');
    BuiltValueNullFieldError.checkNotNull(blocks, r'BlockchainInfo', 'blocks');
    BuiltValueNullFieldError.checkNotNull(
        headers, r'BlockchainInfo', 'headers');
    BuiltValueNullFieldError.checkNotNull(
        bestBlockHash, r'BlockchainInfo', 'bestBlockHash');
    BuiltValueNullFieldError.checkNotNull(
        difficulty, r'BlockchainInfo', 'difficulty');
    BuiltValueNullFieldError.checkNotNull(
        mediantime, r'BlockchainInfo', 'mediantime');
    BuiltValueNullFieldError.checkNotNull(
        verificationProgress, r'BlockchainInfo', 'verificationProgress');
    BuiltValueNullFieldError.checkNotNull(
        initialBlockDownload, r'BlockchainInfo', 'initialBlockDownload');
    BuiltValueNullFieldError.checkNotNull(
        chainwork, r'BlockchainInfo', 'chainwork');
    BuiltValueNullFieldError.checkNotNull(
        sizeOnDisk, r'BlockchainInfo', 'sizeOnDisk');
    BuiltValueNullFieldError.checkNotNull(pruned, r'BlockchainInfo', 'pruned');
    BuiltValueNullFieldError.checkNotNull(
        warnings, r'BlockchainInfo', 'warnings');
    BuiltValueNullFieldError.checkNotNull(
        softforks, r'BlockchainInfo', 'softforks');
  }

  @override
  BlockchainInfo rebuild(void Function(BlockchainInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BlockchainInfoBuilder toBuilder() => BlockchainInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BlockchainInfo &&
        chain == other.chain &&
        blocks == other.blocks &&
        headers == other.headers &&
        bestBlockHash == other.bestBlockHash &&
        difficulty == other.difficulty &&
        mediantime == other.mediantime &&
        verificationProgress == other.verificationProgress &&
        initialBlockDownload == other.initialBlockDownload &&
        chainwork == other.chainwork &&
        sizeOnDisk == other.sizeOnDisk &&
        pruned == other.pruned &&
        pruneHeight == other.pruneHeight &&
        automaticPruning == other.automaticPruning &&
        pruneTargetSize == other.pruneTargetSize &&
        warnings == other.warnings &&
        softforks == other.softforks;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, chain.hashCode);
    _$hash = $jc(_$hash, blocks.hashCode);
    _$hash = $jc(_$hash, headers.hashCode);
    _$hash = $jc(_$hash, bestBlockHash.hashCode);
    _$hash = $jc(_$hash, difficulty.hashCode);
    _$hash = $jc(_$hash, mediantime.hashCode);
    _$hash = $jc(_$hash, verificationProgress.hashCode);
    _$hash = $jc(_$hash, initialBlockDownload.hashCode);
    _$hash = $jc(_$hash, chainwork.hashCode);
    _$hash = $jc(_$hash, sizeOnDisk.hashCode);
    _$hash = $jc(_$hash, pruned.hashCode);
    _$hash = $jc(_$hash, pruneHeight.hashCode);
    _$hash = $jc(_$hash, automaticPruning.hashCode);
    _$hash = $jc(_$hash, pruneTargetSize.hashCode);
    _$hash = $jc(_$hash, warnings.hashCode);
    _$hash = $jc(_$hash, softforks.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BlockchainInfo')
          ..add('chain', chain)
          ..add('blocks', blocks)
          ..add('headers', headers)
          ..add('bestBlockHash', bestBlockHash)
          ..add('difficulty', difficulty)
          ..add('mediantime', mediantime)
          ..add('verificationProgress', verificationProgress)
          ..add('initialBlockDownload', initialBlockDownload)
          ..add('chainwork', chainwork)
          ..add('sizeOnDisk', sizeOnDisk)
          ..add('pruned', pruned)
          ..add('pruneHeight', pruneHeight)
          ..add('automaticPruning', automaticPruning)
          ..add('pruneTargetSize', pruneTargetSize)
          ..add('warnings', warnings)
          ..add('softforks', softforks))
        .toString();
  }
}

class BlockchainInfoBuilder
    implements Builder<BlockchainInfo, BlockchainInfoBuilder> {
  _$BlockchainInfo? _$v;

  String? _chain;
  String? get chain => _$this._chain;
  set chain(String? chain) => _$this._chain = chain;

  int? _blocks;
  int? get blocks => _$this._blocks;
  set blocks(int? blocks) => _$this._blocks = blocks;

  int? _headers;
  int? get headers => _$this._headers;
  set headers(int? headers) => _$this._headers = headers;

  String? _bestBlockHash;
  String? get bestBlockHash => _$this._bestBlockHash;
  set bestBlockHash(String? bestBlockHash) =>
      _$this._bestBlockHash = bestBlockHash;

  int? _difficulty;
  int? get difficulty => _$this._difficulty;
  set difficulty(int? difficulty) => _$this._difficulty = difficulty;

  int? _mediantime;
  int? get mediantime => _$this._mediantime;
  set mediantime(int? mediantime) => _$this._mediantime = mediantime;

  num? _verificationProgress;
  num? get verificationProgress => _$this._verificationProgress;
  set verificationProgress(num? verificationProgress) =>
      _$this._verificationProgress = verificationProgress;

  bool? _initialBlockDownload;
  bool? get initialBlockDownload => _$this._initialBlockDownload;
  set initialBlockDownload(bool? initialBlockDownload) =>
      _$this._initialBlockDownload = initialBlockDownload;

  String? _chainwork;
  String? get chainwork => _$this._chainwork;
  set chainwork(String? chainwork) => _$this._chainwork = chainwork;

  int? _sizeOnDisk;
  int? get sizeOnDisk => _$this._sizeOnDisk;
  set sizeOnDisk(int? sizeOnDisk) => _$this._sizeOnDisk = sizeOnDisk;

  bool? _pruned;
  bool? get pruned => _$this._pruned;
  set pruned(bool? pruned) => _$this._pruned = pruned;

  int? _pruneHeight;
  int? get pruneHeight => _$this._pruneHeight;
  set pruneHeight(int? pruneHeight) => _$this._pruneHeight = pruneHeight;

  bool? _automaticPruning;
  bool? get automaticPruning => _$this._automaticPruning;
  set automaticPruning(bool? automaticPruning) =>
      _$this._automaticPruning = automaticPruning;

  int? _pruneTargetSize;
  int? get pruneTargetSize => _$this._pruneTargetSize;
  set pruneTargetSize(int? pruneTargetSize) =>
      _$this._pruneTargetSize = pruneTargetSize;

  String? _warnings;
  String? get warnings => _$this._warnings;
  set warnings(String? warnings) => _$this._warnings = warnings;

  ListBuilder<SoftFork>? _softforks;
  ListBuilder<SoftFork> get softforks =>
      _$this._softforks ??= ListBuilder<SoftFork>();
  set softforks(ListBuilder<SoftFork>? softforks) =>
      _$this._softforks = softforks;

  BlockchainInfoBuilder() {
    BlockchainInfo._defaults(this);
  }

  BlockchainInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _chain = $v.chain;
      _blocks = $v.blocks;
      _headers = $v.headers;
      _bestBlockHash = $v.bestBlockHash;
      _difficulty = $v.difficulty;
      _mediantime = $v.mediantime;
      _verificationProgress = $v.verificationProgress;
      _initialBlockDownload = $v.initialBlockDownload;
      _chainwork = $v.chainwork;
      _sizeOnDisk = $v.sizeOnDisk;
      _pruned = $v.pruned;
      _pruneHeight = $v.pruneHeight;
      _automaticPruning = $v.automaticPruning;
      _pruneTargetSize = $v.pruneTargetSize;
      _warnings = $v.warnings;
      _softforks = $v.softforks.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BlockchainInfo other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$BlockchainInfo;
  }

  @override
  void update(void Function(BlockchainInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BlockchainInfo build() => _build();

  _$BlockchainInfo _build() {
    _$BlockchainInfo _$result;
    try {
      _$result = _$v ??
          _$BlockchainInfo._(
              chain: BuiltValueNullFieldError.checkNotNull(
                  chain, r'BlockchainInfo', 'chain'),
              blocks: BuiltValueNullFieldError.checkNotNull(
                  blocks, r'BlockchainInfo', 'blocks'),
              headers: BuiltValueNullFieldError.checkNotNull(
                  headers, r'BlockchainInfo', 'headers'),
              bestBlockHash: BuiltValueNullFieldError.checkNotNull(
                  bestBlockHash, r'BlockchainInfo', 'bestBlockHash'),
              difficulty: BuiltValueNullFieldError.checkNotNull(
                  difficulty, r'BlockchainInfo', 'difficulty'),
              mediantime: BuiltValueNullFieldError.checkNotNull(
                  mediantime, r'BlockchainInfo', 'mediantime'),
              verificationProgress: BuiltValueNullFieldError.checkNotNull(
                  verificationProgress, r'BlockchainInfo', 'verificationProgress'),
              initialBlockDownload: BuiltValueNullFieldError.checkNotNull(
                  initialBlockDownload, r'BlockchainInfo', 'initialBlockDownload'),
              chainwork: BuiltValueNullFieldError.checkNotNull(chainwork, r'BlockchainInfo', 'chainwork'),
              sizeOnDisk: BuiltValueNullFieldError.checkNotNull(sizeOnDisk, r'BlockchainInfo', 'sizeOnDisk'),
              pruned: BuiltValueNullFieldError.checkNotNull(pruned, r'BlockchainInfo', 'pruned'),
              pruneHeight: pruneHeight,
              automaticPruning: automaticPruning,
              pruneTargetSize: pruneTargetSize,
              warnings: BuiltValueNullFieldError.checkNotNull(warnings, r'BlockchainInfo', 'warnings'),
              softforks: softforks.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'softforks';
        softforks.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'BlockchainInfo', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
