import 'package:result_dart/result_dart.dart';

import '../../../../shared/errors/app_error.dart';
import '../../domain/entities/address.dart';
import '../../domain/exceptions/zip_code_not_found_viacep_exception.dart';
import '../../domain/exceptions/create_address_exception.dart';
import '../../domain/exceptions/delete_address_exception.dart';
import '../../domain/exceptions/get_address_viacep_exception.dart';
import '../../domain/exceptions/read_address_book_exception.dart';
import '../../domain/exceptions/update_address_exception.dart';
import '../../domain/repositories/address_book_repository.dart';
import '../data_sources/create_address_sqflite_data_source.dart';
import '../data_sources/delete_address_sqflite_data_source.dart';
import '../data_sources/get_address_via_cep_data_source.dart';
import '../data_sources/read_address_book_sqflite_data_source.dart';
import '../data_sources/update_address_sqflite_data_source.dart';
import '../dtos/address_book_dto.dart';
import '../dtos/via_cep_dto.dart';

class AddressBookRepositoryImpl implements AddressBookRepository {
  AddressBookRepositoryImpl(
    this._createAddressSQFLiteDataSource,
    this._readAddressSQFLiteDataSource,
    this._updateAddressSQFLiteDataSource,
    this._deleteAddressSQFLiteDataSource,
    this._getAddressViaCepDataSource,
  );

  final GetAddressViaCepDataSource _getAddressViaCepDataSource;
  final CreateAddressSQFLiteDataSource _createAddressSQFLiteDataSource;
  final ReadAddressBookSQFLiteDataSource _readAddressSQFLiteDataSource;
  final UpdateAddressSQFLiteDataSource _updateAddressSQFLiteDataSource;
  final DeleteAddressSQFLiteDataSource _deleteAddressSQFLiteDataSource;

  @override
  AsyncResult<bool, AppException> createAddress(AddressBookDto dto) async {
    try {
      final result = await _createAddressSQFLiteDataSource.create(dto);

      return Success(result);
    } on CreateAddressException catch (e) {
      return Failure(e);
    }
  }

  @override
  AsyncResult<List<Address>, AppException> readAddressBook(int userId) async {
    try {
      final result = await _readAddressSQFLiteDataSource.getAll(userId);

      return Success(result);
    } on ReadAddressBookException catch (e) {
      return Failure(e);
    }
  }

  @override
  AsyncResult<bool, AppException> updateAddress(AddressBookDto dto) async {
    try {
      final result = await _updateAddressSQFLiteDataSource.update(dto);

      return Success(result);
    } on UpdateAddressException catch (e) {
      return Failure(e);
    }
  }

  @override
  AsyncResult<bool, AppException> deleteAddress(int addressId) async {
    try {
      final result = await _deleteAddressSQFLiteDataSource.delete(addressId);

      return Success(result);
    } on DeleteAddressException catch (e) {
      return Failure(e);
    }
  }

  @override
  AsyncResult<ViaCepDto, AppException> getAddressViaCep(String zipCode) async {
    try {
      final result = await _getAddressViaCepDataSource.getAddress(zipCode);

      return Success(result);
    } on GetAddressViaCepException catch (e) {
      return Failure(e);
    } on ZipCodeNotFoundViaCepException catch (e) {
      return Failure(e);
    }
  }
}
