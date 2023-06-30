import 'package:address_book/app/shared/errors/app_error.dart';

class ReadAddressBookException extends AppException {
  const ReadAddressBookException([String? message, StackTrace? stackTrace])
      : super(message ?? 'Erro ao ler o livro de endereços.', stackTrace);
}
