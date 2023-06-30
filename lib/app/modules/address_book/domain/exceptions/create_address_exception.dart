import 'package:address_book/app/shared/errors/app_error.dart';

class CreateAddressException extends AppException {
  const CreateAddressException([String? message, StackTrace? stackTrace])
      : super(message ?? 'Erro ao inserir endereço no banco de dados.', stackTrace);
}
