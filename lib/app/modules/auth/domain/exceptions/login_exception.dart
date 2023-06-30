import 'package:address_book/app/shared/errors/app_error.dart';

class LoginException extends AppException {
  const LoginException([String? message, StackTrace? stackTrace])
      : super(message ?? 'Erro ao fazer login.', stackTrace);
}
