import '../../../core/domain/entities/base_registry.dart';

class Address extends BaseRegistry {
  const Address({
    required super.id,
    this.title = '',
    required this.zipCode,
    required this.streetAddress,
    required this.streetAddressNumber,
    this.additionalAddress = '',
    required this.district,
    required this.city,
    required this.state,
    this.isFavorite = false,
  });

  final String title;
  final String zipCode;
  final String streetAddress;
  final String streetAddressNumber;
  final String additionalAddress;
  final String district;
  final String city;
  final String state;
  final bool isFavorite;

  Address copyWith({
    int? id,
    String? title,
    String? zipCode,
    String? streetAddress,
    String? streetAddressNumber,
    String? additionalAddress,
    String? district,
    String? city,
    String? state,
    bool? isFavorite,
  }) =>
      Address(
        id: id ?? this.id,
        title: title ?? this.title,
        zipCode: zipCode ?? this.zipCode,
        streetAddress: streetAddress ?? this.streetAddress,
        streetAddressNumber: streetAddressNumber ?? this.streetAddressNumber,
        additionalAddress: additionalAddress ?? this.additionalAddress,
        district: district ?? this.district,
        city: city ?? this.city,
        state: state ?? this.state,
        isFavorite: isFavorite ?? this.isFavorite,
      );
}
