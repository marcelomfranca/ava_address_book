import 'package:address_book/app/shared/errors/app_error.dart';

import '../../../domain/entities/user.dart';

sealed class AuthState {
  const AuthState();
}

class InitialAuthState extends AuthState {
  const InitialAuthState();
}

class GettingInState extends AuthState {
  const GettingInState();
}

class LoggedState extends AuthState {
  const LoggedState(this.user);

  final UserAva user;
}

class AuthFailureState extends AuthState {
  const AuthFailureState(this.error);

  final AppException error;
}
