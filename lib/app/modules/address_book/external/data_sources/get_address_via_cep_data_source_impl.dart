import 'dart:convert';

import '../../domain/exceptions/zip_code_not_found_viacep_exception.dart';
import '../../infra/adapters/viacep_adapter.dart';
import '../../infra/dtos/via_cep_dto.dart';
import 'package:http/http.dart' as http;

import '../../domain/exceptions/get_address_viacep_exception.dart';
import '../../infra/data_sources/get_address_via_cep_data_source.dart';

class GetAddressViaCepDataSourceImpl implements GetAddressViaCepDataSource {
  Future<ViaCepDto> _getAddress(String zipCode) async {
    var response = await http.get(Uri.parse('https://viacep.com.br/ws/$zipCode/json/')).onError(
        (error, stackTrace) => throw GetAddressViaCepException(message: error.toString(), stackTrace: stackTrace));

    if (response.statusCode == 400) {
      throw ZipCodeNotFoundViaCepException(code: response.statusCode.toString());
    } else if (response.statusCode != 200) {
      throw GetAddressViaCepException(code: response.statusCode.toString());
    }

    final data = jsonDecode(utf8.decode(response.bodyBytes));

    return ViaCepAdapter.fromMap(data);
  }

  @override
  Future<ViaCepDto> getAddress(String zipCode) async => _getAddress(zipCode);
}
