import 'package:address_book/app/shared/errors/app_error.dart';

class UpdateUserException extends AppException {
  const UpdateUserException([String? message, StackTrace? stackTrace])
      : super(message ?? 'Erro ao atualizar usuário no banco de dados.', stackTrace);
}
