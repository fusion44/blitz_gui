// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_input.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LoginInput extends LoginInput {
  @override
  final String password;
  @override
  final String? oneTimePassword;

  factory _$LoginInput([void Function(LoginInputBuilder)? updates]) =>
      (LoginInputBuilder()..update(updates))._build();

  _$LoginInput._({required this.password, this.oneTimePassword}) : super._() {
    BuiltValueNullFieldError.checkNotNull(password, r'LoginInput', 'password');
  }

  @override
  LoginInput rebuild(void Function(LoginInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LoginInputBuilder toBuilder() => LoginInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LoginInput &&
        password == other.password &&
        oneTimePassword == other.oneTimePassword;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jc(_$hash, oneTimePassword.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LoginInput')
          ..add('password', password)
          ..add('oneTimePassword', oneTimePassword))
        .toString();
  }
}

class LoginInputBuilder implements Builder<LoginInput, LoginInputBuilder> {
  _$LoginInput? _$v;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  String? _oneTimePassword;
  String? get oneTimePassword => _$this._oneTimePassword;
  set oneTimePassword(String? oneTimePassword) =>
      _$this._oneTimePassword = oneTimePassword;

  LoginInputBuilder() {
    LoginInput._defaults(this);
  }

  LoginInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _password = $v.password;
      _oneTimePassword = $v.oneTimePassword;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LoginInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$LoginInput;
  }

  @override
  void update(void Function(LoginInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LoginInput build() => _build();

  _$LoginInput _build() {
    final _$result = _$v ??
        _$LoginInput._(
            password: BuiltValueNullFieldError.checkNotNull(
                password, r'LoginInput', 'password'),
            oneTimePassword: oneTimePassword);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
