import 'package:address_book/app/shared/errors/app_error.dart';

class CreateUserException extends AppException {
  const CreateUserException([String? message, StackTrace? stackTrace])
      : super(message ?? 'Erro ao criar usuário no banco de dados.', stackTrace);
}
