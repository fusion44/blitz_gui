import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:common/common.dart' as utils;
import 'package:common_widgets/common_widgets.dart';
import 'package:settings_fragment/settings_fragment.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthStateError implements Exception {
  final String message;

  AuthStateError(this.message);
}

class AuthRepo {
  final _controller = StreamController<AuthStatus>();
  late final Stream<AuthStatus> _statusStream;
  var _url = '';
  var _token = '';

  FutureOr<bool> init([bool useCookie = false]) async {
    _statusStream = _controller.stream.asBroadcastStream();

    if (!useCookie || kIsWeb) return false;

    Map<String, String> envVars = Platform.environment;

    if (Platform.isLinux || Platform.isMacOS) {
      String? home = envVars['HOME'];

      if (home != null) {
        var f = File('$home/.blitz_api/.cookie');
        var exists = await f.exists();
        if (!exists) {
          // TODO: remove me. This is a hack. Currently flutter-pi
          // can only be run as root. Check if the file is there
          // and if not, fail
          f = File('/home/blitzapi/.blitz_api/.cookie');
          exists = await f.exists();
          if (!exists) {
            // user must log in normally
            return false;
          }
        }

        _token = 'Bearer ${(await f.readAsString()).trim()}';
        _url = SettingsRepository.instance().defaultEndpoint;
        _controller.add(AuthStatus.authenticated);

        return true;
      }
    }

    return false;
  }

  bool get isLoggedIn => _url.isNotEmpty && _token.isNotEmpty;

  String token() {
    if (_token.isEmpty) {
      throw AuthStateError('AuthRepo.token() called before successful login');
    }

    return 'Bearer $_token';
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
    yield* _statusStream;
  }

  Future<void> logIn({
    required String url,
    required String username,
    required String password,
  }) async {
    var newUrl = url;
    if (!url.endsWith('/')) newUrl = '$url/';
    newUrl += 'latest/system/login';
    try {
      var res = await utils.post(Uri.parse(newUrl), '', {'password': password});
      if (res.statusCode == 200) {
        _url = newUrl.replaceAll('/latest/system/login', '');
        _token = jsonDecode(res.body);
        _controller.add(AuthStatus.authenticated);
      } else if (res.statusCode == 401) {
        throw AuthStateError('Password is wrong');
      } else if (res.statusCode == 423) {
        throw AuthStateError('Node is locked');
      } else {
        throw AuthStateError('Unknown error');
      }
    } on SocketException catch (e) {
      _controller.add(AuthStatus.authenticated);
      utils.BlitzLog().e(e.osError?.toString());
      throw AuthStateError(tr('errors.unable_to_connect_reach_node'));
    }
  }

  void logOut() {
    _token = '';
    _url = '';
    _controller.add(AuthStatus.unauthenticated);
  }

  Future<void> dispose() async {
    _token = '';
    _url = '';
    await _controller.close();
  }

  //-----------------------------------
  // Singleton
  //-----------------------------------
  static AuthRepo? _instance;
  AuthRepo._internal();

  static AuthRepo instance() {
    _instance ??= AuthRepo._internal();

    return _instance!;
  }

  static AuthRepo instanceChecked() {
    if (_instance == null) {
      throw StateError('SubscriptionRepository is not initialized');
    }

    return AuthRepo.instance();
  }
}
