import '../../../core/core_app.dart';
import '../../domain/exceptions/invalid_password_exception.dart';
import '../../domain/exceptions/update_user_exception.dart';
import '../../infra/adapters/user_dto_adapter.dart';
import '../../infra/data_sources/update_user_password_sqflite_data_source.dart';
import '../../infra/dtos/user_dto.dart';

class UpdatePasswordSQFLiteDataSourceImpl implements UpdateUserPasswordSQFLiteDataSource {
  Future<int> _update(UserDto dto) async {
    final database = await CoreApp.instance.dataBase;
    final id = await database.update(
      'Users',
      UserDtoAdapter.toMap(dto),
      where: 'id == ? AND password == ?',
      whereArgs: [dto.id, dto.currentPassword],
    ).onError((error, stackTrace) => throw UpdateUserException(error.toString(), stackTrace));

    final changed = (id > 0);

    if (!changed) throw const InvalidPasswordException();

    return id;
  }

  @override
  Future<int> update(UserDto dto) async => _update(dto);
}
