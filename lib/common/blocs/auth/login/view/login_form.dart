import 'dart:async';

import 'package:blitz_gui/common/widgets/translated_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../utils.dart';
import '../bloc/login_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: TrText('auth.authentication_failed')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _URLInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _PasswordInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _LoginButton(),
          ],
        ),
      ),
    );
  }
}

class _URLInput extends StatefulWidget {
  @override
  State<_URLInput> createState() => _URLInputState();
}

class _URLInputState extends State<_URLInput> {
  final _urlCtrl = TextEditingController();
  late StreamSubscription<LoginState> _sub;

  @override
  void dispose() {
    super.dispose();
    _sub.cancel();
  }

  @override
  void initState() {
    super.initState();
    var bloc = context.read<LoginBloc>();
    _urlCtrl.text = bloc.state.url.value;
    _sub = bloc.stream.listen((state) {
      if (state is LoginState && _urlCtrl.text != state.url.value) {
        _urlCtrl.text = state.url.value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.url != current.url,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_urlInput_textField'),
          controller: _urlCtrl,
          onChanged: (url) =>
              context.read<LoginBloc>().add(LoginUrlChanged(url)),
          decoration: InputDecoration(
            labelText: 'URL',
            errorText:
                state.url.invalid ? tr('auth.invalid_url_input_deco') : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginBloc>().add(LoginPasswordChanged(password)),
          obscureText: true,
          decoration: InputDecoration(
            labelText: tr('auth.password_label'),
            errorText: state.password.invalid
                ? tr('auth.invalid_password_input_deco')
                : null,
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
                child: const TrText('auth.login_btn'),
                onPressed: state.status.isValidated
                    ? () {
                        context.read<LoginBloc>().add(const LoginSubmitted());
                      }
                    : null,
              );
      },
    );
  }
}
