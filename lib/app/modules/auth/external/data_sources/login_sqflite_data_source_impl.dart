import '../../../core/core_app.dart';
import '../../domain/entities/user.dart';
import '../../domain/exceptions/get_user_exception.dart';
import '../../domain/exceptions/invalid_password_exception.dart';
import '../../infra/adapters/user_adapter.dart';
import '../../infra/data_sources/login_sqflite_data_source.dart';
import '../../infra/dtos/user_dto.dart';

class LoginSQFLiteDataSourceImpl implements LoginSQFLiteDataSource {
  Future<UserAva> _login(UserDto dto) async {
    await Future.delayed(const Duration(milliseconds: 600));

    final database = await CoreApp.instance.dataBase;
    final result = await database
        .query('Users',
            columns: ['id, name, email, favoriteAddress, loggedAt'],
            where: 'email == ? AND password == ?',
            whereArgs: [dto.email, dto.password],
            limit: 1)
        .onError((error, stackTrace) => throw GetUserException(error.toString(), stackTrace));

    if (result.isEmpty) throw const InvalidPasswordException();

    return UserAdapter.fromMap(result.first, loggedAt: DateTime.now());
  }

  @override
  Future<UserAva> login(UserDto dto) async => _login(dto);
}
