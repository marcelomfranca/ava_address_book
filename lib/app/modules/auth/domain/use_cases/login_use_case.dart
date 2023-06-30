import 'package:result_dart/result_dart.dart';

import '../../../../shared/errors/app_error.dart';
import '../../../core/domain/use_cases/start_auth_session_use_case.dart';
import '../../infra/dtos/user_dto.dart';
import '../entities/user.dart';
import '../exceptions/login_exception.dart';
import '../exceptions/user_email_exists_exception.dart';
import '../repositories/auth_repository.dart';
import 'check_email_use_case.dart';

class LoginUseCase {
  LoginUseCase(this._authRepository, this._checkEmailUseCase, this._startAuthSessionUseCase);

  final AuthRepository _authRepository;
  final CheckEmailUseCase _checkEmailUseCase;
  final StartAuthSessionUseCase _startAuthSessionUseCase;

  AsyncResult<UserAva, AppException> call(UserDto dto) async {
    AppException? checkEmailException;

    final checkEmail = (await _checkEmailUseCase(dto.email));

    checkEmail.fold((success) => success, (failure) => checkEmailException = failure);

    if (checkEmailException is UserEMailExistsException) {
      final loginResult = await _authRepository.login(dto).fold((success) async => success, (failure) => failure);

      if (loginResult is UserAva) {
        await _startAuthSessionUseCase(loginResult);
        return Success(loginResult);
      }

      return Failure(loginResult as AppException);
    } else if ((checkEmailException != null)) {
      return Failure(checkEmailException!);
    }

    return const Failure(LoginException());
  }
}
