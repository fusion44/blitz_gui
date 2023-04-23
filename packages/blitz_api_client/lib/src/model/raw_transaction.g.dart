// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'raw_transaction.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RawTransaction extends RawTransaction {
  @override
  final bool? inActiveChain;
  @override
  final String txid;
  @override
  final String hash;
  @override
  final int size;
  @override
  final int vsize;
  @override
  final int weight;
  @override
  final int version;
  @override
  final int locktime;
  @override
  final BuiltList<JsonObject> vin;
  @override
  final BuiltList<JsonObject> vout;
  @override
  final String blockhash;
  @override
  final int confirmations;
  @override
  final int blocktime;

  factory _$RawTransaction([void Function(RawTransactionBuilder)? updates]) =>
      (RawTransactionBuilder()..update(updates))._build();

  _$RawTransaction._(
      {this.inActiveChain,
      required this.txid,
      required this.hash,
      required this.size,
      required this.vsize,
      required this.weight,
      required this.version,
      required this.locktime,
      required this.vin,
      required this.vout,
      required this.blockhash,
      required this.confirmations,
      required this.blocktime})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(txid, r'RawTransaction', 'txid');
    BuiltValueNullFieldError.checkNotNull(hash, r'RawTransaction', 'hash');
    BuiltValueNullFieldError.checkNotNull(size, r'RawTransaction', 'size');
    BuiltValueNullFieldError.checkNotNull(vsize, r'RawTransaction', 'vsize');
    BuiltValueNullFieldError.checkNotNull(weight, r'RawTransaction', 'weight');
    BuiltValueNullFieldError.checkNotNull(
        version, r'RawTransaction', 'version');
    BuiltValueNullFieldError.checkNotNull(
        locktime, r'RawTransaction', 'locktime');
    BuiltValueNullFieldError.checkNotNull(vin, r'RawTransaction', 'vin');
    BuiltValueNullFieldError.checkNotNull(vout, r'RawTransaction', 'vout');
    BuiltValueNullFieldError.checkNotNull(
        blockhash, r'RawTransaction', 'blockhash');
    BuiltValueNullFieldError.checkNotNull(
        confirmations, r'RawTransaction', 'confirmations');
    BuiltValueNullFieldError.checkNotNull(
        blocktime, r'RawTransaction', 'blocktime');
  }

  @override
  RawTransaction rebuild(void Function(RawTransactionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RawTransactionBuilder toBuilder() => RawTransactionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RawTransaction &&
        inActiveChain == other.inActiveChain &&
        txid == other.txid &&
        hash == other.hash &&
        size == other.size &&
        vsize == other.vsize &&
        weight == other.weight &&
        version == other.version &&
        locktime == other.locktime &&
        vin == other.vin &&
        vout == other.vout &&
        blockhash == other.blockhash &&
        confirmations == other.confirmations &&
        blocktime == other.blocktime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, inActiveChain.hashCode);
    _$hash = $jc(_$hash, txid.hashCode);
    _$hash = $jc(_$hash, hash.hashCode);
    _$hash = $jc(_$hash, size.hashCode);
    _$hash = $jc(_$hash, vsize.hashCode);
    _$hash = $jc(_$hash, weight.hashCode);
    _$hash = $jc(_$hash, version.hashCode);
    _$hash = $jc(_$hash, locktime.hashCode);
    _$hash = $jc(_$hash, vin.hashCode);
    _$hash = $jc(_$hash, vout.hashCode);
    _$hash = $jc(_$hash, blockhash.hashCode);
    _$hash = $jc(_$hash, confirmations.hashCode);
    _$hash = $jc(_$hash, blocktime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RawTransaction')
          ..add('inActiveChain', inActiveChain)
          ..add('txid', txid)
          ..add('hash', hash)
          ..add('size', size)
          ..add('vsize', vsize)
          ..add('weight', weight)
          ..add('version', version)
          ..add('locktime', locktime)
          ..add('vin', vin)
          ..add('vout', vout)
          ..add('blockhash', blockhash)
          ..add('confirmations', confirmations)
          ..add('blocktime', blocktime))
        .toString();
  }
}

class RawTransactionBuilder
    implements Builder<RawTransaction, RawTransactionBuilder> {
  _$RawTransaction? _$v;

  bool? _inActiveChain;
  bool? get inActiveChain => _$this._inActiveChain;
  set inActiveChain(bool? inActiveChain) =>
      _$this._inActiveChain = inActiveChain;

  String? _txid;
  String? get txid => _$this._txid;
  set txid(String? txid) => _$this._txid = txid;

  String? _hash;
  String? get hash => _$this._hash;
  set hash(String? hash) => _$this._hash = hash;

  int? _size;
  int? get size => _$this._size;
  set size(int? size) => _$this._size = size;

  int? _vsize;
  int? get vsize => _$this._vsize;
  set vsize(int? vsize) => _$this._vsize = vsize;

  int? _weight;
  int? get weight => _$this._weight;
  set weight(int? weight) => _$this._weight = weight;

  int? _version;
  int? get version => _$this._version;
  set version(int? version) => _$this._version = version;

  int? _locktime;
  int? get locktime => _$this._locktime;
  set locktime(int? locktime) => _$this._locktime = locktime;

  ListBuilder<JsonObject>? _vin;
  ListBuilder<JsonObject> get vin => _$this._vin ??= ListBuilder<JsonObject>();
  set vin(ListBuilder<JsonObject>? vin) => _$this._vin = vin;

  ListBuilder<JsonObject>? _vout;
  ListBuilder<JsonObject> get vout =>
      _$this._vout ??= ListBuilder<JsonObject>();
  set vout(ListBuilder<JsonObject>? vout) => _$this._vout = vout;

  String? _blockhash;
  String? get blockhash => _$this._blockhash;
  set blockhash(String? blockhash) => _$this._blockhash = blockhash;

  int? _confirmations;
  int? get confirmations => _$this._confirmations;
  set confirmations(int? confirmations) =>
      _$this._confirmations = confirmations;

  int? _blocktime;
  int? get blocktime => _$this._blocktime;
  set blocktime(int? blocktime) => _$this._blocktime = blocktime;

  RawTransactionBuilder() {
    RawTransaction._defaults(this);
  }

  RawTransactionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _inActiveChain = $v.inActiveChain;
      _txid = $v.txid;
      _hash = $v.hash;
      _size = $v.size;
      _vsize = $v.vsize;
      _weight = $v.weight;
      _version = $v.version;
      _locktime = $v.locktime;
      _vin = $v.vin.toBuilder();
      _vout = $v.vout.toBuilder();
      _blockhash = $v.blockhash;
      _confirmations = $v.confirmations;
      _blocktime = $v.blocktime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RawTransaction other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$RawTransaction;
  }

  @override
  void update(void Function(RawTransactionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RawTransaction build() => _build();

  _$RawTransaction _build() {
    _$RawTransaction _$result;
    try {
      _$result = _$v ??
          _$RawTransaction._(
              inActiveChain: inActiveChain,
              txid: BuiltValueNullFieldError.checkNotNull(
                  txid, r'RawTransaction', 'txid'),
              hash: BuiltValueNullFieldError.checkNotNull(
                  hash, r'RawTransaction', 'hash'),
              size: BuiltValueNullFieldError.checkNotNull(
                  size, r'RawTransaction', 'size'),
              vsize: BuiltValueNullFieldError.checkNotNull(
                  vsize, r'RawTransaction', 'vsize'),
              weight: BuiltValueNullFieldError.checkNotNull(
                  weight, r'RawTransaction', 'weight'),
              version: BuiltValueNullFieldError.checkNotNull(
                  version, r'RawTransaction', 'version'),
              locktime: BuiltValueNullFieldError.checkNotNull(
                  locktime, r'RawTransaction', 'locktime'),
              vin: vin.build(),
              vout: vout.build(),
              blockhash: BuiltValueNullFieldError.checkNotNull(
                  blockhash, r'RawTransaction', 'blockhash'),
              confirmations: BuiltValueNullFieldError.checkNotNull(
                  confirmations, r'RawTransaction', 'confirmations'),
              blocktime:
                  BuiltValueNullFieldError.checkNotNull(blocktime, r'RawTransaction', 'blocktime'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vin';
        vin.build();
        _$failedField = 'vout';
        vout.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'RawTransaction', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
