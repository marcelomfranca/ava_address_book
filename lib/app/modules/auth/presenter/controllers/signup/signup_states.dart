abstract interface class SignUpState {
  const SignUpState();
}

class InitialSignUpState extends SignUpState {
  const InitialSignUpState();
}

class RegisteringUserState extends SignUpState {
  const RegisteringUserState();
}

class CheckingEmailState extends SignUpState {
  const CheckingEmailState();
}

class EmailCheckedState extends SignUpState {
  const EmailCheckedState(this.result);

  final String? result;
}

class RegisteredUserState extends SignUpState {
  const RegisteredUserState();
}

class UserRegistrationFailureState extends SignUpState {
  const UserRegistrationFailureState(this.message);

  final String message;
}
