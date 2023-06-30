import 'package:result_dart/result_dart.dart';

import '../../../../shared/errors/app_error.dart';
import '../../../core/domain/use_cases/start_auth_session_use_case.dart';
import '../../infra/dtos/user_dto.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class CreateUserUseCase {
  CreateUserUseCase(this._authRepository, this._startAuthSessionUseCase);

  final AuthRepository _authRepository;
  final StartAuthSessionUseCase _startAuthSessionUseCase;

  AsyncResult<UserAva, AppException> call(UserDto dto) async => (await _authRepository.createUser(dto))
    ..fold((success) async {
      await _startAuthSessionUseCase(success);
      return success;
    }, (failure) => failure);
}
