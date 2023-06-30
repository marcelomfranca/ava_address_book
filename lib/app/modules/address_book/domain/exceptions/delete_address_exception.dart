import 'package:address_book/app/shared/errors/app_error.dart';

class DeleteAddressException extends AppException {
  const DeleteAddressException([String? message, StackTrace? stackTrace])
      : super(message ?? 'Erro ao excluir endereço no banco de dados.', stackTrace);
}
