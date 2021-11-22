import 'dart:async';
import 'dart:convert';

import 'package:common/common.dart' as utils;

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthStateError implements Exception {
  final String message;

  AuthStateError(this.message);
}

class AuthRepo {
  final _controller = StreamController<AuthStatus>();
  var _url = '';
  var _token = '';

  String token() {
    if (_token.isEmpty) {
      throw AuthStateError('AuthRepo.token() called before successful login');
    }
    return _token;
  }

  String baseUrl() {
    if (_url.isEmpty) {
      throw AuthStateError('AuthRepo.baseUrl() called before successful login');
    }
    return _url;
  }

  Stream<AuthStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String url,
    required String username,
    required String password,
  }) async {
    var newUrl = url;
    if (!url.endsWith('/')) newUrl = url + '/';
    newUrl += 'latest/system/login';
    var res = await utils.post(Uri.parse(newUrl), '', {'password': password});
    if (res.statusCode == 200) {
      _url = newUrl.replaceAll('/latest/system/login', '');
      final jsonBody = jsonDecode(res.body);
      _token = 'Bearer ${jsonBody["access_token"]}';
      _controller.add(AuthStatus.authenticated);
    }
  }

  void logOut() {
    _token = '';
    _url = '';
    _controller.add(AuthStatus.unauthenticated);
  }

  void dispose() {
    _token = '';
    _url = '';
    _controller.close();
  }
}
