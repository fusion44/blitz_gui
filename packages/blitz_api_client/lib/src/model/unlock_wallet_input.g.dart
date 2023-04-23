// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unlock_wallet_input.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UnlockWalletInput extends UnlockWalletInput {
  @override
  final String password;

  factory _$UnlockWalletInput(
          [void Function(UnlockWalletInputBuilder)? updates]) =>
      (UnlockWalletInputBuilder()..update(updates))._build();

  _$UnlockWalletInput._({required this.password}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        password, r'UnlockWalletInput', 'password');
  }

  @override
  UnlockWalletInput rebuild(void Function(UnlockWalletInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UnlockWalletInputBuilder toBuilder() =>
      UnlockWalletInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UnlockWalletInput && password == other.password;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UnlockWalletInput')
          ..add('password', password))
        .toString();
  }
}

class UnlockWalletInputBuilder
    implements Builder<UnlockWalletInput, UnlockWalletInputBuilder> {
  _$UnlockWalletInput? _$v;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  UnlockWalletInputBuilder() {
    UnlockWalletInput._defaults(this);
  }

  UnlockWalletInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _password = $v.password;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UnlockWalletInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UnlockWalletInput;
  }

  @override
  void update(void Function(UnlockWalletInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UnlockWalletInput build() => _build();

  _$UnlockWalletInput _build() {
    final _$result = _$v ??
        _$UnlockWalletInput._(
            password: BuiltValueNullFieldError.checkNotNull(
                password, r'UnlockWalletInput', 'password'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
