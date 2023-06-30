import 'package:result_dart/result_dart.dart';

import '../../../../shared/errors/app_error.dart';
import '../../domain/entities/user.dart';
import '../../domain/exceptions/create_user_exception.dart';
import '../../domain/exceptions/get_user_exception.dart';
import '../../domain/exceptions/user_email_exists_exception.dart';
import '../../domain/exceptions/user_email_not_exists_exception.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/check_email_sqflite_data_source.dart';
import '../data_sources/create_user_sqflite_data_source.dart';
import '../data_sources/login_sqflite_data_source.dart';
import '../data_sources/update_user_password_sqflite_data_source.dart';
import '../dtos/user_dto.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(
    this._checkEmailSQFLiteDataSource,
    this._loginSQFLiteDataSource,
    this._createUserSQFLiteDataSource,
    this._updateUserPasswordSQFLiteDataSource,
  );

  final CheckEmailSQFLiteDataSource _checkEmailSQFLiteDataSource;
  final LoginSQFLiteDataSource _loginSQFLiteDataSource;
  final CreateUserSQFLiteDataSource _createUserSQFLiteDataSource;
  final UpdateUserPasswordSQFLiteDataSource _updateUserPasswordSQFLiteDataSource;

  @override
  AsyncResult<bool, AppException> checkEmail(String email) async {
    try {
      final result = await _checkEmailSQFLiteDataSource.exists(email);

      return Success(result);
    } on GetUserException catch (e) {
      return Failure(e);
    } on UserEMailNotExistsException catch (e) {
      return Failure(e);
    } on UserEMailExistsException catch (e) {
      return Failure(e);
    }
  }

  @override
  AsyncResult<UserAva, AppException> createUser(UserDto dto) async {
    try {
      final result = await _createUserSQFLiteDataSource.create(dto);

      return Success(result);
    } on CreateUserException catch (e) {
      return Failure(e);
    }
  }

  @override
  AsyncResult<int, AppException> updateUserPassword(UserDto dto) async {
    try {
      final result = await _updateUserPasswordSQFLiteDataSource.update(dto);

      return Success(result);
    } on AppException catch (e) {
      return Failure(e);
    }
  }

  @override
  AsyncResult<UserAva, AppException> login(UserDto dto) async {
    try {
      final result = await _loginSQFLiteDataSource.login(dto);

      return Success(result);
    } on AppException catch (e) {
      return Failure(e);
    }
  }
}
