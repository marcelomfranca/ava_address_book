import 'package:address_book/app/shared/errors/app_error.dart';

class ZipCodeNotFoundViaCepException extends AppException {
  const ZipCodeNotFoundViaCepException({String? message, String? code, StackTrace? stackTrace})
      : super(message ?? 'Cep não encontrado.', stackTrace);
}
