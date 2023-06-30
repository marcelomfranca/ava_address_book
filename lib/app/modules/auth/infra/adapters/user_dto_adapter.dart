import '../dtos/user_dto.dart';

abstract class UserDtoAdapter {
  UserDtoAdapter._();

  static Map<String, dynamic> toMap(UserDto dto) => {
        'name': dto.name,
        'email': dto.email,
        'password': dto.password,
        'loggedAt': dto.loggedAt?.toString(),
      };
}
