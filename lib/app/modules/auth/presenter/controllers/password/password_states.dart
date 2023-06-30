import '../../../../../shared/errors/app_error.dart';

sealed class PasswordState {
  const PasswordState();
}

class InitialPasswordState extends PasswordState {
  const InitialPasswordState();
}

class ChangingPasswordState extends PasswordState {
  const ChangingPasswordState();
}

class InvalidPasswordState extends PasswordState {
  const InvalidPasswordState(this.error);

  final AppException error;
}

class PasswordChangedState extends PasswordState {
  const PasswordChangedState();
}

class PasswordChangeFailureState extends PasswordState {
  const PasswordChangeFailureState(this.message);

  final String message;
}
