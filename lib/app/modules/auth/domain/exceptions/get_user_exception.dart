import 'package:address_book/app/shared/errors/app_error.dart';

class GetUserException extends AppException {
  const GetUserException([String? message, StackTrace? stackTrace])
      : super(message ?? 'Erro ao acessar banco de dados.', stackTrace);
}
