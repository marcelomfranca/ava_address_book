import '../../../core/core_app.dart';
import '../../domain/exceptions/delete_address_exception.dart';
import '../../infra/data_sources/delete_address_sqflite_data_source.dart';

class DeleteAddressSQFLiteDataSourceImpl implements DeleteAddressSQFLiteDataSource {
  Future<bool> _delete(int addressId) async {
    final database = await CoreApp.instance.dataBase;
    final id = await database.delete('AddressBook', where: 'id == ?', whereArgs: [addressId]).onError(
        (error, stackTrace) => throw DeleteAddressException(error.toString(), stackTrace));

    return (id == 1);
  }

  @override
  Future<bool> delete(int addressId) async => _delete(addressId);
}
