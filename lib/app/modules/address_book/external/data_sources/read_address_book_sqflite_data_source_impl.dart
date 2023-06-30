import '../../../core/core_app.dart';
import '../../domain/entities/address.dart';
import '../../domain/exceptions/read_address_book_exception.dart';
import '../../infra/adapters/address_adapter.dart';
import '../../infra/data_sources/read_address_book_sqflite_data_source.dart';

class ReadAddressBookSQFLiteDataSourceImpl implements ReadAddressBookSQFLiteDataSource {
  Future<List<Address>> _getAll(int userId) async {
    final database = await CoreApp.instance.dataBase;
    final result = await database
        .query(
          'AddressBook',
          where: 'userId == ?',
          whereArgs: [userId],
          orderBy: 'title DESC',
        )
        .onError((error, stackTrace) => throw ReadAddressBookException(error.toString(), stackTrace));

    return AddressAdapter.fromMapList(result);
  }

  @override
  Future<List<Address>> getAll(int userId) async => _getAll(userId);
}
