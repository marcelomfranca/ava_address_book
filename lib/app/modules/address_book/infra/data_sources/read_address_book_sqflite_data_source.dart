import 'package:address_book/app/modules/address_book/domain/entities/address.dart';

abstract class ReadAddressBookSQFLiteDataSource {
  Future<List<Address>> getAll(int userId);
}
