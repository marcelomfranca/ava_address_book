import 'package:result_dart/result_dart.dart';

import '../../../../shared/errors/app_error.dart';
import '../../infra/dtos/address_book_dto.dart';
import '../../infra/dtos/via_cep_dto.dart';
import '../entities/address.dart';

abstract interface class AddressBookRepository {
  AsyncResult<bool, AppException> createAddress(AddressBookDto dto);
  AsyncResult<List<Address>, AppException> readAddressBook(int userId);
  AsyncResult<bool, AppException> updateAddress(AddressBookDto dto);
  AsyncResult<bool, AppException> deleteAddress(int addressId);
  AsyncResult<ViaCepDto, AppException> getAddressViaCep(String dto);
}
