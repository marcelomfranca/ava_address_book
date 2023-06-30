import '../../../core/core_app.dart';
import '../../domain/exceptions/update_address_exception.dart';
import '../../infra/adapters/address_book_adapter.dart';
import '../../infra/data_sources/update_address_sqflite_data_source.dart';
import '../../infra/dtos/address_book_dto.dart';

class UpdateAddressSQFLiteDataSourceImpl implements UpdateAddressSQFLiteDataSource {
  Future<bool> _update(AddressBookDto dto) async {
    final database = await CoreApp.instance.dataBase;
    final id = await database.update(
      'AddressBook',
      AddressBookAdapter.toMap(dto),
      where: 'id == ? AND userId == ?',
      whereArgs: [dto.id, dto.userId],
    ).onError((error, stackTrace) => throw UpdateAddressException(error.toString(), stackTrace));

    return (id > 0);
  }

  @override
  Future<bool> update(AddressBookDto dto) async => _update(dto);
}
