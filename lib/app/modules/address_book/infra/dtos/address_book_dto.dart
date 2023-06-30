import 'package:flutter/foundation.dart';

@immutable
class AddressBookDto {
  const AddressBookDto({
    this.id,
    required this.userId,
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

  final int? id;
  final int userId;
  final String title;
  final String zipCode;
  final String streetAddress;
  final String streetAddressNumber;
  final String additionalAddress;
  final String district;
  final String city;
  final String state;
  final bool isFavorite;

  AddressBookDto copyWith({
    int? id,
    int? userId,
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
      AddressBookDto(
        id: id ?? this.id,
        userId: userId ?? this.userId,
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
