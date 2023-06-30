import 'package:address_book/app/shared/errors/app_error.dart';

class UserEMailExistsException extends AppException {
  const UserEMailExistsException([String? message, StackTrace? stackTrace])
      : super(message ?? 'E-Mail já cadastrado.', stackTrace);
}
