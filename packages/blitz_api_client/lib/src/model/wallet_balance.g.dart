// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_balance.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WalletBalance extends WalletBalance {
  @override
  final int onchainConfirmedBalance;
  @override
  final int onchainTotalBalance;
  @override
  final int onchainUnconfirmedBalance;
  @override
  final int channelLocalBalance;
  @override
  final int channelRemoteBalance;
  @override
  final int channelUnsettledLocalBalance;
  @override
  final int channelUnsettledRemoteBalance;
  @override
  final int channelPendingOpenLocalBalance;
  @override
  final int channelPendingOpenRemoteBalance;

  factory _$WalletBalance([void Function(WalletBalanceBuilder)? updates]) =>
      (WalletBalanceBuilder()..update(updates))._build();

  _$WalletBalance._(
      {required this.onchainConfirmedBalance,
      required this.onchainTotalBalance,
      required this.onchainUnconfirmedBalance,
      required this.channelLocalBalance,
      required this.channelRemoteBalance,
      required this.channelUnsettledLocalBalance,
      required this.channelUnsettledRemoteBalance,
      required this.channelPendingOpenLocalBalance,
      required this.channelPendingOpenRemoteBalance})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        onchainConfirmedBalance, r'WalletBalance', 'onchainConfirmedBalance');
    BuiltValueNullFieldError.checkNotNull(
        onchainTotalBalance, r'WalletBalance', 'onchainTotalBalance');
    BuiltValueNullFieldError.checkNotNull(onchainUnconfirmedBalance,
        r'WalletBalance', 'onchainUnconfirmedBalance');
    BuiltValueNullFieldError.checkNotNull(
        channelLocalBalance, r'WalletBalance', 'channelLocalBalance');
    BuiltValueNullFieldError.checkNotNull(
        channelRemoteBalance, r'WalletBalance', 'channelRemoteBalance');
    BuiltValueNullFieldError.checkNotNull(channelUnsettledLocalBalance,
        r'WalletBalance', 'channelUnsettledLocalBalance');
    BuiltValueNullFieldError.checkNotNull(channelUnsettledRemoteBalance,
        r'WalletBalance', 'channelUnsettledRemoteBalance');
    BuiltValueNullFieldError.checkNotNull(channelPendingOpenLocalBalance,
        r'WalletBalance', 'channelPendingOpenLocalBalance');
    BuiltValueNullFieldError.checkNotNull(channelPendingOpenRemoteBalance,
        r'WalletBalance', 'channelPendingOpenRemoteBalance');
  }

  @override
  WalletBalance rebuild(void Function(WalletBalanceBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WalletBalanceBuilder toBuilder() => WalletBalanceBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WalletBalance &&
        onchainConfirmedBalance == other.onchainConfirmedBalance &&
        onchainTotalBalance == other.onchainTotalBalance &&
        onchainUnconfirmedBalance == other.onchainUnconfirmedBalance &&
        channelLocalBalance == other.channelLocalBalance &&
        channelRemoteBalance == other.channelRemoteBalance &&
        channelUnsettledLocalBalance == other.channelUnsettledLocalBalance &&
        channelUnsettledRemoteBalance == other.channelUnsettledRemoteBalance &&
        channelPendingOpenLocalBalance ==
            other.channelPendingOpenLocalBalance &&
        channelPendingOpenRemoteBalance ==
            other.channelPendingOpenRemoteBalance;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, onchainConfirmedBalance.hashCode);
    _$hash = $jc(_$hash, onchainTotalBalance.hashCode);
    _$hash = $jc(_$hash, onchainUnconfirmedBalance.hashCode);
    _$hash = $jc(_$hash, channelLocalBalance.hashCode);
    _$hash = $jc(_$hash, channelRemoteBalance.hashCode);
    _$hash = $jc(_$hash, channelUnsettledLocalBalance.hashCode);
    _$hash = $jc(_$hash, channelUnsettledRemoteBalance.hashCode);
    _$hash = $jc(_$hash, channelPendingOpenLocalBalance.hashCode);
    _$hash = $jc(_$hash, channelPendingOpenRemoteBalance.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WalletBalance')
          ..add('onchainConfirmedBalance', onchainConfirmedBalance)
          ..add('onchainTotalBalance', onchainTotalBalance)
          ..add('onchainUnconfirmedBalance', onchainUnconfirmedBalance)
          ..add('channelLocalBalance', channelLocalBalance)
          ..add('channelRemoteBalance', channelRemoteBalance)
          ..add('channelUnsettledLocalBalance', channelUnsettledLocalBalance)
          ..add('channelUnsettledRemoteBalance', channelUnsettledRemoteBalance)
          ..add(
              'channelPendingOpenLocalBalance', channelPendingOpenLocalBalance)
          ..add('channelPendingOpenRemoteBalance',
              channelPendingOpenRemoteBalance))
        .toString();
  }
}

class WalletBalanceBuilder
    implements Builder<WalletBalance, WalletBalanceBuilder> {
  _$WalletBalance? _$v;

  int? _onchainConfirmedBalance;
  int? get onchainConfirmedBalance => _$this._onchainConfirmedBalance;
  set onchainConfirmedBalance(int? onchainConfirmedBalance) =>
      _$this._onchainConfirmedBalance = onchainConfirmedBalance;

  int? _onchainTotalBalance;
  int? get onchainTotalBalance => _$this._onchainTotalBalance;
  set onchainTotalBalance(int? onchainTotalBalance) =>
      _$this._onchainTotalBalance = onchainTotalBalance;

  int? _onchainUnconfirmedBalance;
  int? get onchainUnconfirmedBalance => _$this._onchainUnconfirmedBalance;
  set onchainUnconfirmedBalance(int? onchainUnconfirmedBalance) =>
      _$this._onchainUnconfirmedBalance = onchainUnconfirmedBalance;

  int? _channelLocalBalance;
  int? get channelLocalBalance => _$this._channelLocalBalance;
  set channelLocalBalance(int? channelLocalBalance) =>
      _$this._channelLocalBalance = channelLocalBalance;

  int? _channelRemoteBalance;
  int? get channelRemoteBalance => _$this._channelRemoteBalance;
  set channelRemoteBalance(int? channelRemoteBalance) =>
      _$this._channelRemoteBalance = channelRemoteBalance;

  int? _channelUnsettledLocalBalance;
  int? get channelUnsettledLocalBalance => _$this._channelUnsettledLocalBalance;
  set channelUnsettledLocalBalance(int? channelUnsettledLocalBalance) =>
      _$this._channelUnsettledLocalBalance = channelUnsettledLocalBalance;

  int? _channelUnsettledRemoteBalance;
  int? get channelUnsettledRemoteBalance =>
      _$this._channelUnsettledRemoteBalance;
  set channelUnsettledRemoteBalance(int? channelUnsettledRemoteBalance) =>
      _$this._channelUnsettledRemoteBalance = channelUnsettledRemoteBalance;

  int? _channelPendingOpenLocalBalance;
  int? get channelPendingOpenLocalBalance =>
      _$this._channelPendingOpenLocalBalance;
  set channelPendingOpenLocalBalance(int? channelPendingOpenLocalBalance) =>
      _$this._channelPendingOpenLocalBalance = channelPendingOpenLocalBalance;

  int? _channelPendingOpenRemoteBalance;
  int? get channelPendingOpenRemoteBalance =>
      _$this._channelPendingOpenRemoteBalance;
  set channelPendingOpenRemoteBalance(int? channelPendingOpenRemoteBalance) =>
      _$this._channelPendingOpenRemoteBalance = channelPendingOpenRemoteBalance;

  WalletBalanceBuilder() {
    WalletBalance._defaults(this);
  }

  WalletBalanceBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _onchainConfirmedBalance = $v.onchainConfirmedBalance;
      _onchainTotalBalance = $v.onchainTotalBalance;
      _onchainUnconfirmedBalance = $v.onchainUnconfirmedBalance;
      _channelLocalBalance = $v.channelLocalBalance;
      _channelRemoteBalance = $v.channelRemoteBalance;
      _channelUnsettledLocalBalance = $v.channelUnsettledLocalBalance;
      _channelUnsettledRemoteBalance = $v.channelUnsettledRemoteBalance;
      _channelPendingOpenLocalBalance = $v.channelPendingOpenLocalBalance;
      _channelPendingOpenRemoteBalance = $v.channelPendingOpenRemoteBalance;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WalletBalance other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$WalletBalance;
  }

  @override
  void update(void Function(WalletBalanceBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WalletBalance build() => _build();

  _$WalletBalance _build() {
    final _$result = _$v ??
        _$WalletBalance._(
            onchainConfirmedBalance: BuiltValueNullFieldError.checkNotNull(
                onchainConfirmedBalance, r'WalletBalance', 'onchainConfirmedBalance'),
            onchainTotalBalance: BuiltValueNullFieldError.checkNotNull(
                onchainTotalBalance, r'WalletBalance', 'onchainTotalBalance'),
            onchainUnconfirmedBalance: BuiltValueNullFieldError.checkNotNull(
                onchainUnconfirmedBalance, r'WalletBalance', 'onchainUnconfirmedBalance'),
            channelLocalBalance: BuiltValueNullFieldError.checkNotNull(
                channelLocalBalance, r'WalletBalance', 'channelLocalBalance'),
            channelRemoteBalance: BuiltValueNullFieldError.checkNotNull(
                channelRemoteBalance, r'WalletBalance', 'channelRemoteBalance'),
            channelUnsettledLocalBalance: BuiltValueNullFieldError.checkNotNull(
                channelUnsettledLocalBalance, r'WalletBalance', 'channelUnsettledLocalBalance'),
            channelUnsettledRemoteBalance:
                BuiltValueNullFieldError.checkNotNull(channelUnsettledRemoteBalance, r'WalletBalance', 'channelUnsettledRemoteBalance'),
            channelPendingOpenLocalBalance: BuiltValueNullFieldError.checkNotNull(channelPendingOpenLocalBalance, r'WalletBalance', 'channelPendingOpenLocalBalance'),
            channelPendingOpenRemoteBalance: BuiltValueNullFieldError.checkNotNull(channelPendingOpenRemoteBalance, r'WalletBalance', 'channelPendingOpenRemoteBalance'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
