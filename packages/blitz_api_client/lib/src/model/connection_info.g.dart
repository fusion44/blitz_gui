// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ConnectionInfo extends ConnectionInfo {
  @override
  final String? lndAdminMacaroon;
  @override
  final String? lndInvoiceMacaroon;
  @override
  final String? lndReadonlyMacaroon;
  @override
  final String? lndTlsCert;
  @override
  final String? lndRestOnion;
  @override
  final String? lndBtcpayConnectionString;
  @override
  final String? lndZeusConnectionString;
  @override
  final String? clRestZeusConnectionString;
  @override
  final String? clRestMacaroon;
  @override
  final String? clRestOnion;

  factory _$ConnectionInfo([void Function(ConnectionInfoBuilder)? updates]) =>
      (ConnectionInfoBuilder()..update(updates))._build();

  _$ConnectionInfo._(
      {this.lndAdminMacaroon,
      this.lndInvoiceMacaroon,
      this.lndReadonlyMacaroon,
      this.lndTlsCert,
      this.lndRestOnion,
      this.lndBtcpayConnectionString,
      this.lndZeusConnectionString,
      this.clRestZeusConnectionString,
      this.clRestMacaroon,
      this.clRestOnion})
      : super._();

  @override
  ConnectionInfo rebuild(void Function(ConnectionInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ConnectionInfoBuilder toBuilder() => ConnectionInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ConnectionInfo &&
        lndAdminMacaroon == other.lndAdminMacaroon &&
        lndInvoiceMacaroon == other.lndInvoiceMacaroon &&
        lndReadonlyMacaroon == other.lndReadonlyMacaroon &&
        lndTlsCert == other.lndTlsCert &&
        lndRestOnion == other.lndRestOnion &&
        lndBtcpayConnectionString == other.lndBtcpayConnectionString &&
        lndZeusConnectionString == other.lndZeusConnectionString &&
        clRestZeusConnectionString == other.clRestZeusConnectionString &&
        clRestMacaroon == other.clRestMacaroon &&
        clRestOnion == other.clRestOnion;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, lndAdminMacaroon.hashCode);
    _$hash = $jc(_$hash, lndInvoiceMacaroon.hashCode);
    _$hash = $jc(_$hash, lndReadonlyMacaroon.hashCode);
    _$hash = $jc(_$hash, lndTlsCert.hashCode);
    _$hash = $jc(_$hash, lndRestOnion.hashCode);
    _$hash = $jc(_$hash, lndBtcpayConnectionString.hashCode);
    _$hash = $jc(_$hash, lndZeusConnectionString.hashCode);
    _$hash = $jc(_$hash, clRestZeusConnectionString.hashCode);
    _$hash = $jc(_$hash, clRestMacaroon.hashCode);
    _$hash = $jc(_$hash, clRestOnion.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ConnectionInfo')
          ..add('lndAdminMacaroon', lndAdminMacaroon)
          ..add('lndInvoiceMacaroon', lndInvoiceMacaroon)
          ..add('lndReadonlyMacaroon', lndReadonlyMacaroon)
          ..add('lndTlsCert', lndTlsCert)
          ..add('lndRestOnion', lndRestOnion)
          ..add('lndBtcpayConnectionString', lndBtcpayConnectionString)
          ..add('lndZeusConnectionString', lndZeusConnectionString)
          ..add('clRestZeusConnectionString', clRestZeusConnectionString)
          ..add('clRestMacaroon', clRestMacaroon)
          ..add('clRestOnion', clRestOnion))
        .toString();
  }
}

class ConnectionInfoBuilder
    implements Builder<ConnectionInfo, ConnectionInfoBuilder> {
  _$ConnectionInfo? _$v;

  String? _lndAdminMacaroon;
  String? get lndAdminMacaroon => _$this._lndAdminMacaroon;
  set lndAdminMacaroon(String? lndAdminMacaroon) =>
      _$this._lndAdminMacaroon = lndAdminMacaroon;

  String? _lndInvoiceMacaroon;
  String? get lndInvoiceMacaroon => _$this._lndInvoiceMacaroon;
  set lndInvoiceMacaroon(String? lndInvoiceMacaroon) =>
      _$this._lndInvoiceMacaroon = lndInvoiceMacaroon;

  String? _lndReadonlyMacaroon;
  String? get lndReadonlyMacaroon => _$this._lndReadonlyMacaroon;
  set lndReadonlyMacaroon(String? lndReadonlyMacaroon) =>
      _$this._lndReadonlyMacaroon = lndReadonlyMacaroon;

  String? _lndTlsCert;
  String? get lndTlsCert => _$this._lndTlsCert;
  set lndTlsCert(String? lndTlsCert) => _$this._lndTlsCert = lndTlsCert;

  String? _lndRestOnion;
  String? get lndRestOnion => _$this._lndRestOnion;
  set lndRestOnion(String? lndRestOnion) => _$this._lndRestOnion = lndRestOnion;

  String? _lndBtcpayConnectionString;
  String? get lndBtcpayConnectionString => _$this._lndBtcpayConnectionString;
  set lndBtcpayConnectionString(String? lndBtcpayConnectionString) =>
      _$this._lndBtcpayConnectionString = lndBtcpayConnectionString;

  String? _lndZeusConnectionString;
  String? get lndZeusConnectionString => _$this._lndZeusConnectionString;
  set lndZeusConnectionString(String? lndZeusConnectionString) =>
      _$this._lndZeusConnectionString = lndZeusConnectionString;

  String? _clRestZeusConnectionString;
  String? get clRestZeusConnectionString => _$this._clRestZeusConnectionString;
  set clRestZeusConnectionString(String? clRestZeusConnectionString) =>
      _$this._clRestZeusConnectionString = clRestZeusConnectionString;

  String? _clRestMacaroon;
  String? get clRestMacaroon => _$this._clRestMacaroon;
  set clRestMacaroon(String? clRestMacaroon) =>
      _$this._clRestMacaroon = clRestMacaroon;

  String? _clRestOnion;
  String? get clRestOnion => _$this._clRestOnion;
  set clRestOnion(String? clRestOnion) => _$this._clRestOnion = clRestOnion;

  ConnectionInfoBuilder() {
    ConnectionInfo._defaults(this);
  }

  ConnectionInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _lndAdminMacaroon = $v.lndAdminMacaroon;
      _lndInvoiceMacaroon = $v.lndInvoiceMacaroon;
      _lndReadonlyMacaroon = $v.lndReadonlyMacaroon;
      _lndTlsCert = $v.lndTlsCert;
      _lndRestOnion = $v.lndRestOnion;
      _lndBtcpayConnectionString = $v.lndBtcpayConnectionString;
      _lndZeusConnectionString = $v.lndZeusConnectionString;
      _clRestZeusConnectionString = $v.clRestZeusConnectionString;
      _clRestMacaroon = $v.clRestMacaroon;
      _clRestOnion = $v.clRestOnion;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ConnectionInfo other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ConnectionInfo;
  }

  @override
  void update(void Function(ConnectionInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ConnectionInfo build() => _build();

  _$ConnectionInfo _build() {
    final _$result = _$v ??
        _$ConnectionInfo._(
            lndAdminMacaroon: lndAdminMacaroon,
            lndInvoiceMacaroon: lndInvoiceMacaroon,
            lndReadonlyMacaroon: lndReadonlyMacaroon,
            lndTlsCert: lndTlsCert,
            lndRestOnion: lndRestOnion,
            lndBtcpayConnectionString: lndBtcpayConnectionString,
            lndZeusConnectionString: lndZeusConnectionString,
            clRestZeusConnectionString: clRestZeusConnectionString,
            clRestMacaroon: clRestMacaroon,
            clRestOnion: clRestOnion);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
