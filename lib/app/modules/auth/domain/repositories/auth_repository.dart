import 'package:result_dart/result_dart.dart';

import '../../../../shared/errors/app_error.dart';
import '../../infra/dtos/user_dto.dart';
import '../entities/user.dart';

abstract interface class AuthRepository {
  AsyncResult<bool, AppException> checkEmail(String email);
  AsyncResult<UserAva, AppException> createUser(UserDto dto);
  AsyncResult<int, AppException> updateUserPassword(UserDto dto);
  AsyncResult<UserAva, AppException> login(UserDto dto);
}
