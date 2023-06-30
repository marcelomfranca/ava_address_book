import 'package:result_dart/result_dart.dart';

import '../../../../shared/errors/app_error.dart';
import '../../infra/dtos/address_book_dto.dart';
import '../repositories/address_book_repository.dart';

class CreateAddressUseCase {
  CreateAddressUseCase(this._addressBookRepository);

  final AddressBookRepository _addressBookRepository;

  AsyncResult<bool, AppException> call(AddressBookDto dto) async => _addressBookRepository.createAddress(dto);
}
