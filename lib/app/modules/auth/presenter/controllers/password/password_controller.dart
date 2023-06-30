import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/update_user_password_use_case.dart';
import '../../../infra/dtos/user_dto.dart';
import 'password_states.dart';

class ChangePasswordController extends Cubit<PasswordState> {
  ChangePasswordController(this._updateUserPasswordUseCase) : super(const InitialPasswordState());

  final UpdateUserPasswordUseCase _updateUserPasswordUseCase;

  Future<void> updateUserPassword(UserDto userDto) async {
    emit(const ChangingPasswordState());

    final successOrFailure = await _updateUserPasswordUseCase(userDto);

    emit(
      successOrFailure.fold(
        (success) => const PasswordChangedState(),
        (failure) => InvalidPasswordState(failure),
      ),
    );
  }
}
