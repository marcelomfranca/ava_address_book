import 'package:address_book/app/shared/errors/app_error.dart';

class UserEMailNotExistsException extends AppException {
  const UserEMailNotExistsException([String? message, StackTrace? stackTrace])
      : super(message ?? 'E-Mail disponível', stackTrace);
}
