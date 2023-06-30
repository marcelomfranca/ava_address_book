import 'package:address_book/app/shared/errors/app_error.dart';

class GetAddressViaCepException extends AppException {
  const GetAddressViaCepException({String? message, String? code, StackTrace? stackTrace})
      : super(message ?? 'Erro ao acessar api via cep. [${(code ?? '')}]', stackTrace);
}
