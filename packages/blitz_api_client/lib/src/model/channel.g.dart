// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Channel extends Channel {
  @override
  final String? channelId;
  @override
  final ChannelState? state;
  @override
  final bool active;
  @override
  final String peerPublickey;
  @override
  final String? peerAlias;
  @override
  final int? balanceLocal;
  @override
  final int? balanceRemote;
  @override
  final int? balanceCapacity;
  @override
  final bool? dualFunded;
  @override
  final ChannelInitiator? initiator;
  @override
  final ChannelInitiator? closer;

  factory _$Channel([void Function(ChannelBuilder)? updates]) =>
      (ChannelBuilder()..update(updates))._build();

  _$Channel._(
      {this.channelId,
      this.state,
      required this.active,
      required this.peerPublickey,
      this.peerAlias,
      this.balanceLocal,
      this.balanceRemote,
      this.balanceCapacity,
      this.dualFunded,
      this.initiator,
      this.closer})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(active, r'Channel', 'active');
    BuiltValueNullFieldError.checkNotNull(
        peerPublickey, r'Channel', 'peerPublickey');
  }

  @override
  Channel rebuild(void Function(ChannelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChannelBuilder toBuilder() => ChannelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Channel &&
        channelId == other.channelId &&
        state == other.state &&
        active == other.active &&
        peerPublickey == other.peerPublickey &&
        peerAlias == other.peerAlias &&
        balanceLocal == other.balanceLocal &&
        balanceRemote == other.balanceRemote &&
        balanceCapacity == other.balanceCapacity &&
        dualFunded == other.dualFunded &&
        initiator == other.initiator &&
        closer == other.closer;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, channelId.hashCode);
    _$hash = $jc(_$hash, state.hashCode);
    _$hash = $jc(_$hash, active.hashCode);
    _$hash = $jc(_$hash, peerPublickey.hashCode);
    _$hash = $jc(_$hash, peerAlias.hashCode);
    _$hash = $jc(_$hash, balanceLocal.hashCode);
    _$hash = $jc(_$hash, balanceRemote.hashCode);
    _$hash = $jc(_$hash, balanceCapacity.hashCode);
    _$hash = $jc(_$hash, dualFunded.hashCode);
    _$hash = $jc(_$hash, initiator.hashCode);
    _$hash = $jc(_$hash, closer.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Channel')
          ..add('channelId', channelId)
          ..add('state', state)
          ..add('active', active)
          ..add('peerPublickey', peerPublickey)
          ..add('peerAlias', peerAlias)
          ..add('balanceLocal', balanceLocal)
          ..add('balanceRemote', balanceRemote)
          ..add('balanceCapacity', balanceCapacity)
          ..add('dualFunded', dualFunded)
          ..add('initiator', initiator)
          ..add('closer', closer))
        .toString();
  }
}

class ChannelBuilder implements Builder<Channel, ChannelBuilder> {
  _$Channel? _$v;

  String? _channelId;
  String? get channelId => _$this._channelId;
  set channelId(String? channelId) => _$this._channelId = channelId;

  ChannelState? _state;
  ChannelState? get state => _$this._state;
  set state(ChannelState? state) => _$this._state = state;

  bool? _active;
  bool? get active => _$this._active;
  set active(bool? active) => _$this._active = active;

  String? _peerPublickey;
  String? get peerPublickey => _$this._peerPublickey;
  set peerPublickey(String? peerPublickey) =>
      _$this._peerPublickey = peerPublickey;

  String? _peerAlias;
  String? get peerAlias => _$this._peerAlias;
  set peerAlias(String? peerAlias) => _$this._peerAlias = peerAlias;

  int? _balanceLocal;
  int? get balanceLocal => _$this._balanceLocal;
  set balanceLocal(int? balanceLocal) => _$this._balanceLocal = balanceLocal;

  int? _balanceRemote;
  int? get balanceRemote => _$this._balanceRemote;
  set balanceRemote(int? balanceRemote) =>
      _$this._balanceRemote = balanceRemote;

  int? _balanceCapacity;
  int? get balanceCapacity => _$this._balanceCapacity;
  set balanceCapacity(int? balanceCapacity) =>
      _$this._balanceCapacity = balanceCapacity;

  bool? _dualFunded;
  bool? get dualFunded => _$this._dualFunded;
  set dualFunded(bool? dualFunded) => _$this._dualFunded = dualFunded;

  ChannelInitiator? _initiator;
  ChannelInitiator? get initiator => _$this._initiator;
  set initiator(ChannelInitiator? initiator) => _$this._initiator = initiator;

  ChannelInitiator? _closer;
  ChannelInitiator? get closer => _$this._closer;
  set closer(ChannelInitiator? closer) => _$this._closer = closer;

  ChannelBuilder() {
    Channel._defaults(this);
  }

  ChannelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _channelId = $v.channelId;
      _state = $v.state;
      _active = $v.active;
      _peerPublickey = $v.peerPublickey;
      _peerAlias = $v.peerAlias;
      _balanceLocal = $v.balanceLocal;
      _balanceRemote = $v.balanceRemote;
      _balanceCapacity = $v.balanceCapacity;
      _dualFunded = $v.dualFunded;
      _initiator = $v.initiator;
      _closer = $v.closer;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Channel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Channel;
  }

  @override
  void update(void Function(ChannelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Channel build() => _build();

  _$Channel _build() {
    final _$result = _$v ??
        _$Channel._(
            channelId: channelId,
            state: state,
            active: BuiltValueNullFieldError.checkNotNull(
                active, r'Channel', 'active'),
            peerPublickey: BuiltValueNullFieldError.checkNotNull(
                peerPublickey, r'Channel', 'peerPublickey'),
            peerAlias: peerAlias,
            balanceLocal: balanceLocal,
            balanceRemote: balanceRemote,
            balanceCapacity: balanceCapacity,
            dualFunded: dualFunded,
            initiator: initiator,
            closer: closer);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
