import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required AuthRepo authRepository,
  })  : _authRepo = authRepository,
        super(const AuthState.unknown()) {
    on<AuthStatusChanged>(_onAuthStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    if (_authRepo.isLoggedIn) {
      add(const AuthStatusChanged(AuthStatus.authenticated));
    }
    _authStatusSub = _authRepo.status.listen(
      (status) => add(AuthStatusChanged(status)),
    );
  }

  final AuthRepo _authRepo;
  late StreamSubscription<AuthStatus> _authStatusSub;

  @override
  Future<void> close() {
    _authStatusSub.cancel();
    _authRepo.dispose();
    return super.close();
  }

  void _onAuthStatusChanged(
    AuthStatusChanged event,
    Emitter<AuthState> emit,
  ) async {
    switch (event.status) {
      case AuthStatus.unauthenticated:
        return emit(const AuthState.unauthenticated());
      case AuthStatus.authenticated:
        return emit(const AuthState.authenticated());
      default:
        return emit(const AuthState.unknown());
    }
  }

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthState> emit,
  ) {
    _authRepo.logOut();
  }
}
