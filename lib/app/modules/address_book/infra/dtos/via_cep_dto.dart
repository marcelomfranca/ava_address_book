import 'package:flutter/foundation.dart';

@immutable
class ViaCepDto {
  const ViaCepDto({
    required this.cep,
    required this.streetAddress,
    required this.additionalAddress,
    required this.district,
    required this.city,
    required this.state,
  });

  final String cep;
  final String streetAddress;
  final String additionalAddress;
  final String district;
  final String city;
  final String state;
}
