import '../../../core/core_app.dart';
import '../../domain/exceptions/get_user_exception.dart';
import '../../domain/exceptions/user_email_exists_exception.dart';
import '../../domain/exceptions/user_email_not_exists_exception.dart';
import '../../infra/data_sources/check_email_sqflite_data_source.dart';

class CheckEmailSQFLiteDataSourceImpl implements CheckEmailSQFLiteDataSource {
  Future<bool> _exists(String email) async {
    await Future.delayed(const Duration(milliseconds: 600));

    final database = await CoreApp.instance.dataBase;
    final result = await database
        .query('Users', columns: ['email'], where: 'email == ?', whereArgs: [email], limit: 1)
        .onError((error, stackTrace) => throw GetUserException(error.toString(), stackTrace));

    if (result.isNotEmpty) throw const UserEMailExistsException();

    throw const UserEMailNotExistsException();
  }

  @override
  Future<bool> exists(String email) async => _exists(email);
}
