import 'package:address_book/app/shared/errors/app_error.dart';

class UserNotRegisteredException extends AppException {
  const UserNotRegisteredException([String? message, StackTrace? stackTrace])
      : super(message ?? 'Usuário não cadastrado.', stackTrace);
}
