import '../../domain/entities/user.dart';
import '../../domain/exceptions/create_user_exception.dart';
import '../../infra/adapters/user_dto_adapter.dart';
import '../../../core/core_app.dart';

import '../../infra/data_sources/create_user_sqflite_data_source.dart';
import '../../infra/dtos/user_dto.dart';

class CreateUserSQFLiteDataSourceImpl implements CreateUserSQFLiteDataSource {
  Future<UserAva> _create(UserDto dto) async {
    await Future.delayed(const Duration(milliseconds: 600));

    final database = await CoreApp.instance.dataBase;
    final userDto = dto.copyWith(loggedAt: DateTime.now());
    final id = await database
        .insert('Users', UserDtoAdapter.toMap(userDto))
        .onError((error, stackTrace) => throw CreateUserException(error.toString(), stackTrace));

    return UserAva(id: id, name: userDto.name, email: userDto.email, loggedAt: userDto.loggedAt);
  }

  @override
  Future<UserAva> create(UserDto dto) async => _create(dto);
}
