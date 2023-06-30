import '../../domain/exceptions/create_address_exception.dart';
import '../../infra/adapters/address_book_adapter.dart';

import '../../../core/core_app.dart';
import '../../infra/data_sources/create_address_sqflite_data_source.dart';
import '../../infra/dtos/address_book_dto.dart';

class CreateAddressSQFLiteDataSourceImpl implements CreateAddressSQFLiteDataSource {
  Future<bool> _create(AddressBookDto dto) async {
    await Future.delayed(const Duration(milliseconds: 600));

    final database = await CoreApp.instance.dataBase;
    final id = await database
        .insert('AddressBook', AddressBookAdapter.toMap(dto))
        .onError((error, stackTrace) => throw CreateAddressException(error.toString(), stackTrace));

    return (id > 0);
  }

  @override
  Future<bool> create(AddressBookDto dto) async => _create(dto);
}
