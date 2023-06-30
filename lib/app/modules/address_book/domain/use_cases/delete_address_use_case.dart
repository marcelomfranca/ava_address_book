import 'package:result_dart/result_dart.dart';

import '../../../../shared/errors/app_error.dart';
import '../repositories/address_book_repository.dart';

class DeleteAddressUseCase {
  DeleteAddressUseCase(this._addressBookRepository);

  final AddressBookRepository _addressBookRepository;

  AsyncResult<bool, AppException> call(int addressId) async => _addressBookRepository.deleteAddress(addressId);
}
