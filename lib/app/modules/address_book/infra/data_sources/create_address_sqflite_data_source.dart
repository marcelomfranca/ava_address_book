import 'package:address_book/app/modules/address_book/infra/dtos/address_book_dto.dart';

abstract class CreateAddressSQFLiteDataSource {
  Future<bool> create(AddressBookDto dto);
}
