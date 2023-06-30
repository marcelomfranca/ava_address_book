import 'package:result_dart/result_dart.dart';

import '../../../../shared/errors/app_error.dart';
import '../entities/address.dart';
import '../repositories/address_book_repository.dart';

class ReadAddressBookUseCase {
  ReadAddressBookUseCase(this._addressBookRepository);

  final AddressBookRepository _addressBookRepository;

  AsyncResult<List<Address>, AppException> call(int userId) async => _addressBookRepository.readAddressBook(userId);
}
