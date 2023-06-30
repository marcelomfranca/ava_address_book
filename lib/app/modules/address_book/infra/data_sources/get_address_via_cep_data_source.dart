import '../dtos/via_cep_dto.dart';

abstract interface class GetAddressViaCepDataSource {
  Future<ViaCepDto> getAddress(String zipCode);
}
