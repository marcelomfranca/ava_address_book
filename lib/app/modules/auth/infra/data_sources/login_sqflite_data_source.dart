import '../../domain/entities/user.dart';
import '../dtos/user_dto.dart';

abstract interface class LoginSQFLiteDataSource {
  Future<UserAva> login(UserDto dto);
}
