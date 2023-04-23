// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'btc_network.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BtcNetwork extends BtcNetwork {
  @override
  final String name;
  @override
  final bool limited;
  @override
  final bool reachable;
  @override
  final String? proxy;
  @override
  final bool proxyRandomizeCredentials;

  factory _$BtcNetwork([void Function(BtcNetworkBuilder)? updates]) =>
      (BtcNetworkBuilder()..update(updates))._build();

  _$BtcNetwork._(
      {required this.name,
      required this.limited,
      required this.reachable,
      this.proxy,
      required this.proxyRandomizeCredentials})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(name, r'BtcNetwork', 'name');
    BuiltValueNullFieldError.checkNotNull(limited, r'BtcNetwork', 'limited');
    BuiltValueNullFieldError.checkNotNull(
        reachable, r'BtcNetwork', 'reachable');
    BuiltValueNullFieldError.checkNotNull(
        proxyRandomizeCredentials, r'BtcNetwork', 'proxyRandomizeCredentials');
  }

  @override
  BtcNetwork rebuild(void Function(BtcNetworkBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BtcNetworkBuilder toBuilder() => BtcNetworkBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BtcNetwork &&
        name == other.name &&
        limited == other.limited &&
        reachable == other.reachable &&
        proxy == other.proxy &&
        proxyRandomizeCredentials == other.proxyRandomizeCredentials;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, limited.hashCode);
    _$hash = $jc(_$hash, reachable.hashCode);
    _$hash = $jc(_$hash, proxy.hashCode);
    _$hash = $jc(_$hash, proxyRandomizeCredentials.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BtcNetwork')
          ..add('name', name)
          ..add('limited', limited)
          ..add('reachable', reachable)
          ..add('proxy', proxy)
          ..add('proxyRandomizeCredentials', proxyRandomizeCredentials))
        .toString();
  }
}

class BtcNetworkBuilder implements Builder<BtcNetwork, BtcNetworkBuilder> {
  _$BtcNetwork? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  bool? _limited;
  bool? get limited => _$this._limited;
  set limited(bool? limited) => _$this._limited = limited;

  bool? _reachable;
  bool? get reachable => _$this._reachable;
  set reachable(bool? reachable) => _$this._reachable = reachable;

  String? _proxy;
  String? get proxy => _$this._proxy;
  set proxy(String? proxy) => _$this._proxy = proxy;

  bool? _proxyRandomizeCredentials;
  bool? get proxyRandomizeCredentials => _$this._proxyRandomizeCredentials;
  set proxyRandomizeCredentials(bool? proxyRandomizeCredentials) =>
      _$this._proxyRandomizeCredentials = proxyRandomizeCredentials;

  BtcNetworkBuilder() {
    BtcNetwork._defaults(this);
  }

  BtcNetworkBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _limited = $v.limited;
      _reachable = $v.reachable;
      _proxy = $v.proxy;
      _proxyRandomizeCredentials = $v.proxyRandomizeCredentials;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BtcNetwork other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$BtcNetwork;
  }

  @override
  void update(void Function(BtcNetworkBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BtcNetwork build() => _build();

  _$BtcNetwork _build() {
    final _$result = _$v ??
        _$BtcNetwork._(
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'BtcNetwork', 'name'),
            limited: BuiltValueNullFieldError.checkNotNull(
                limited, r'BtcNetwork', 'limited'),
            reachable: BuiltValueNullFieldError.checkNotNull(
                reachable, r'BtcNetwork', 'reachable'),
            proxy: proxy,
            proxyRandomizeCredentials: BuiltValueNullFieldError.checkNotNull(
                proxyRandomizeCredentials,
                r'BtcNetwork',
                'proxyRandomizeCredentials'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
