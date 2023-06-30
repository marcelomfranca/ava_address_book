import '../dtos/user_dto.dart';

abstract interface class UpdateUserPasswordSQFLiteDataSource {
  Future<int> update(UserDto dto);
}
