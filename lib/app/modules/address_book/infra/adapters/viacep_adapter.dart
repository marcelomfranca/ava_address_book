import '../dtos/via_cep_dto.dart';

abstract class ViaCepAdapter {
  ViaCepAdapter._();

  static ViaCepDto fromMap(Map<String, dynamic> map) {
    return ViaCepDto(
      cep: map['cep'] ?? '',
      streetAddress: map['logradouro'] ?? '',
      additionalAddress: map['complemento'] ?? '',
      district: map['bairro'] ?? '',
      city: map['localidade'] ?? '',
      state: map['uf'] ?? '',
    );
  }
}
