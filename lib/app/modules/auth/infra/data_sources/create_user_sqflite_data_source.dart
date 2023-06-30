import '../../domain/entities/user.dart';
import '../dtos/user_dto.dart';

abstract interface class CreateUserSQFLiteDataSource {
  Future<UserAva> create(UserDto dto);
}
