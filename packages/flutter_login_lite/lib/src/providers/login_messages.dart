import 'package:common/common.dart';
import 'package:flutter/material.dart';

class LoginMessages with ChangeNotifier {
  final passwordHint = tr('auth.password_label');
  final confirmPasswordHint = tr('auth.confirm_password_label');
  final forgotPasswordButton = tr('auth.forgot_password_label');
  final loginButton = tr('auth.login_btn');
  final recoverPasswordIntro = tr('auth.recover_password_intro_short');
  final recoverPasswordDescription = tr('auth.recover_password_long_explainer');
  final goBackButton = tr('auth.back_btn');
  final flushbarTitleSuccess = tr('auth.snackbar_success_title');
  final flushbarTitleError = tr('auth.snackbar_error_title');
  final urlHint = tr('auth.url_label');
}
