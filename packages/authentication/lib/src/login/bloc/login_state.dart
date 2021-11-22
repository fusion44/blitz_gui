part of 'login_bloc.dart';

class LoginState extends Equatable {
  final FormzStatus status;
  final BlitzURL url;
  final Username username;
  final Password password;

  const LoginState({
    this.status = FormzStatus.pure,
    this.url = const BlitzURL.pure(),
    this.username = const Username.pure(),
    this.password = const Password.pure(),
  });

  LoginState copyWith({
    FormzStatus? status,
    BlitzURL? url,
    Username? username,
    Password? password,
  }) {
    return LoginState(
      status: status ?? this.status,
      url: url ?? this.url,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [status, url, username, password];
}
