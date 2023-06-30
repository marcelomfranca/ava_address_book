import 'package:address_book/app/shared/errors/app_error.dart';

class InvalidPasswordException extends AppException {
  const InvalidPasswordException([String? message, StackTrace? stackTrace])
      : super(message ?? 'Senha inválida.', stackTrace);
}
