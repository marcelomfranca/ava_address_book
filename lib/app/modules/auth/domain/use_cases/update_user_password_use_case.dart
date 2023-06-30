import 'package:result_dart/result_dart.dart';

import '../../../../shared/errors/app_error.dart';
import '../../infra/dtos/user_dto.dart';
import '../exceptions/update_user_exception.dart';
import '../repositories/auth_repository.dart';

class UpdateUserPasswordUseCase {
  UpdateUserPasswordUseCase(this._authRepository);

  final AuthRepository _authRepository;

  AsyncResult<int, AppException> call(UserDto dto) async {
    if (dto.id == null) throw const UpdateUserException('Usuário inválido.');

    if (dto.currentPassword == null) throw const UpdateUserException('Senha inválida.');

    return _authRepository.updateUserPassword(dto);
  }
}
