// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'btc_local_address.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BtcLocalAddress extends BtcLocalAddress {
  @override
  final String address;
  @override
  final int port;
  @override
  final int score;

  factory _$BtcLocalAddress([void Function(BtcLocalAddressBuilder)? updates]) =>
      (BtcLocalAddressBuilder()..update(updates))._build();

  _$BtcLocalAddress._(
      {required this.address, required this.port, required this.score})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        address, r'BtcLocalAddress', 'address');
    BuiltValueNullFieldError.checkNotNull(port, r'BtcLocalAddress', 'port');
    BuiltValueNullFieldError.checkNotNull(score, r'BtcLocalAddress', 'score');
  }

  @override
  BtcLocalAddress rebuild(void Function(BtcLocalAddressBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BtcLocalAddressBuilder toBuilder() => BtcLocalAddressBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BtcLocalAddress &&
        address == other.address &&
        port == other.port &&
        score == other.score;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, port.hashCode);
    _$hash = $jc(_$hash, score.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BtcLocalAddress')
          ..add('address', address)
          ..add('port', port)
          ..add('score', score))
        .toString();
  }
}

class BtcLocalAddressBuilder
    implements Builder<BtcLocalAddress, BtcLocalAddressBuilder> {
  _$BtcLocalAddress? _$v;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  int? _port;
  int? get port => _$this._port;
  set port(int? port) => _$this._port = port;

  int? _score;
  int? get score => _$this._score;
  set score(int? score) => _$this._score = score;

  BtcLocalAddressBuilder() {
    BtcLocalAddress._defaults(this);
  }

  BtcLocalAddressBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _address = $v.address;
      _port = $v.port;
      _score = $v.score;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BtcLocalAddress other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$BtcLocalAddress;
  }

  @override
  void update(void Function(BtcLocalAddressBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BtcLocalAddress build() => _build();

  _$BtcLocalAddress _build() {
    final _$result = _$v ??
        _$BtcLocalAddress._(
            address: BuiltValueNullFieldError.checkNotNull(
                address, r'BtcLocalAddress', 'address'),
            port: BuiltValueNullFieldError.checkNotNull(
                port, r'BtcLocalAddress', 'port'),
            score: BuiltValueNullFieldError.checkNotNull(
                score, r'BtcLocalAddress', 'score'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
