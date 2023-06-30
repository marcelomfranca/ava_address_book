import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/exceptions/user_email_not_exists_exception.dart';
import '../../../domain/use_cases/check_email_use_case.dart';
import '../../../domain/use_cases/create_user_use_case.dart';
import '../../../infra/dtos/user_dto.dart';
import 'signup_states.dart';

class SignUpController extends Cubit<SignUpState> {
  SignUpController(this._createUserUseCase, this._checkEmailUseCase) : super(const InitialSignUpState());

  final CreateUserUseCase _createUserUseCase;
  final CheckEmailUseCase _checkEmailUseCase;

  Future<void> createUser(UserDto userDto) async {
    emit(const RegisteringUserState());

    final successOrFailure = await _createUserUseCase(userDto);

    await checkEmail(userDto.email, emitOff: true);

    emit(
      successOrFailure.fold(
        (success) => const RegisteredUserState(),
        (failure) => UserRegistrationFailureState(failure.message),
      ),
    );
  }

  Future<String?> checkEmail(String email, {bool emitOff = false}) async {
    if (!emitOff) emit(const CheckingEmailState());

    final successOrFailure = await _checkEmailUseCase(email);

    var result = successOrFailure.fold((success) => null, (failure) => failure);

    if (result is UserEMailNotExistsException) result = null;

    if (!emitOff) emit(EmailCheckedState(result?.message));

    return result?.message;
  }
}
