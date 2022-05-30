import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_lite/flutter_login.dart';

import '../../auth/auth_repository.dart';

class LoginPage extends StatelessWidget {
  static String path = '/login';
  static String routeName = 'login';

  final Function onSubmitAnimationCompleted;

  const LoginPage(this.onSubmitAnimationCompleted, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: FlutterLogin(
          onRecoverPassword: (String a) {
            debugPrint('onRecoverPassword not implemented yet');

            return null;
          },
          onLogin: (LoginData data) async => await onLogin(data, context),
          title: 'Raspiblitz Touch',
          messages: LoginMessages(),
          logoTag: 'RaspiBlitz_Logo_Icon_Negative',
          logo: Image.asset('assets/RaspiBlitz_Logo_Icon_Negative.png').image,
          theme: LoginTheme().copyWith(
            pageColorDark: Colors.transparent,
            pageColorLight: Colors.transparent,
          ),
          savedUrl: 'http://127.0.0.1:8000/',
          onSubmitAnimationCompleted: onSubmitAnimationCompleted,
        ),
      ),
    );
  }

  Future<String> onLogin(LoginData data, BuildContext context) async {
    final authRepo = RepositoryProvider.of<AuthRepo>(context);
    try {
      await authRepo.logIn(
        url: data.url,
        username: 'admin',
        password: data.password,
      );
      return '';
    } on AuthStateError catch (e) {
      return e.message;
    }
  }
}
