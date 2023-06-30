import 'package:address_book/app/shared/errors/app_error.dart';

class UpdateAddressException extends AppException {
  const UpdateAddressException([String? message, StackTrace? stackTrace])
      : super(message ?? 'Erro ao atualizar endereço no banco de dados.', stackTrace);
}
