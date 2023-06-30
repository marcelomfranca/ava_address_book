import '../../../core/domain/exceptions/validate_exception.dart';

mixin class AddressDtoValidate {
  void cepValidate(String zipCode) {
    if (zipCode.isEmpty) {
      throw ValidateException('cep', 'O cep  não pode ser vazio');
    }
  }

  void streetAddressValidate(String streetAddress) {
    if (streetAddress.isEmpty) {
      throw ValidateException('streetAddress', 'A rua não pode ser vazio');
    }
  }

  void streetAddressNumberValidate(String streetAddressNumber) {
    if (streetAddressNumber.isEmpty) {
      throw ValidateException('streetAddressNumber', 'O número não pode ser vazio');
    }
  }

  void districtValidate(String district) {
    if (district.isEmpty) {
      throw ValidateException('district', 'O bairro não pode ser vazio');
    }
  }

  void cityValidate(String city) {
    if (city.isEmpty) {
      throw ValidateException('city', 'A cidade não pode ser vazio');
    }
  }

  void stateValidate(String state) {
    if (state.isEmpty) {
      throw ValidateException('state', 'O estado não pode ser vazio');
    }
  }
}
