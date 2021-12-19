import 'package:flutter/material.dart';

import '../../flutter_login.dart';

enum AuthMode { login }

enum AuthType { provider, userPassword }

/// The callback triggered after login
/// The result is an error message, callback successes if message is null
typedef LoginCallback = Future<String?>? Function(LoginData);

/// If the callback returns true, the additional data card is shown
typedef ProviderNeedsSignUpCallback = Future<bool> Function();

/// The result is an error message, callback successes if message is null
typedef ProviderAuthCallback = Future<String?>? Function();

/// The result is an error message, callback successes if message is null
typedef RecoverCallback = Future<String?>? Function(String);

/// The result is an error message, callback successes if message is null
typedef ConfirmRecoverCallback = Future<String?>? Function(String, LoginData);

class Auth with ChangeNotifier {
  Auth({
    this.onLogin,
    this.onRecoverPassword,
    this.onConfirmRecover,
    String url = '',
    String password = '',
    AuthMode initialAuthMode = AuthMode.login,
    this.termsOfService = const [],
  })  : _url = url,
        _password = password,
        _mode = initialAuthMode;

  final LoginCallback? onLogin;
  final RecoverCallback? onRecoverPassword;
  final ConfirmRecoverCallback? onConfirmRecover;
  final List<TermOfService> termsOfService;

  AuthMode _mode = AuthMode.login;
  AuthMode get mode => _mode;
  set mode(AuthMode value) {
    _mode = value;
    notifyListeners();
  }

  bool get isLogin => _mode == AuthMode.login;
  int currentCardIndex = 0;

  String _url = '';
  String get url => _url;
  set url(String url) {
    _url = url;
    notifyListeners();
  }

  String _password = '';
  String get password => _password;
  set password(String password) {
    _password = password;
    notifyListeners();
  }

  List<TermOfServiceResult> getTermsOfServiceResults() {
    return termsOfService
        .map((e) => TermOfServiceResult(term: e, accepted: e.getStatus()))
        .toList();
  }
}
