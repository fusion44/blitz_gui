// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chain.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Chain extends Chain {
  @override
  final String chain;
  @override
  final String network;

  factory _$Chain([void Function(ChainBuilder)? updates]) =>
      (ChainBuilder()..update(updates))._build();

  _$Chain._({required this.chain, required this.network}) : super._() {
    BuiltValueNullFieldError.checkNotNull(chain, r'Chain', 'chain');
    BuiltValueNullFieldError.checkNotNull(network, r'Chain', 'network');
  }

  @override
  Chain rebuild(void Function(ChainBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChainBuilder toBuilder() => ChainBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Chain && chain == other.chain && network == other.network;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, chain.hashCode);
    _$hash = $jc(_$hash, network.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Chain')
          ..add('chain', chain)
          ..add('network', network))
        .toString();
  }
}

class ChainBuilder implements Builder<Chain, ChainBuilder> {
  _$Chain? _$v;

  String? _chain;
  String? get chain => _$this._chain;
  set chain(String? chain) => _$this._chain = chain;

  String? _network;
  String? get network => _$this._network;
  set network(String? network) => _$this._network = network;

  ChainBuilder() {
    Chain._defaults(this);
  }

  ChainBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _chain = $v.chain;
      _network = $v.network;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Chain other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Chain;
  }

  @override
  void update(void Function(ChainBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Chain build() => _build();

  _$Chain _build() {
    final _$result = _$v ??
        _$Chain._(
            chain:
                BuiltValueNullFieldError.checkNotNull(chain, r'Chain', 'chain'),
            network: BuiltValueNullFieldError.checkNotNull(
                network, r'Chain', 'network'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
