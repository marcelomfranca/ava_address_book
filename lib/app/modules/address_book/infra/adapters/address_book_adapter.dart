import '../dtos/address_book_dto.dart';

abstract class AddressBookAdapter {
  AddressBookAdapter._();

  static AddressBookDto fromMap(Map<String, dynamic> map) {
    return AddressBookDto(
      id: map['id'],
      userId: map['userId'],
      title: map['title'],
      zipCode: map['zipCode'],
      streetAddress: map['streetAddress'],
      streetAddressNumber: map['streetAddressNumber'],
      district: map['district'],
      city: map['city'],
      state: map['state'],
    );
  }

  static Map<String, dynamic> toMap(AddressBookDto address) => {
        'id': address.id,
        'userId': address.userId,
        'title': address.title,
        'zipCode': address.zipCode,
        'streetAddress': address.streetAddress,
        'streetAddressNumber': address.streetAddressNumber,
        'additionalAddress': address.additionalAddress,
        'district': address.district,
        'city': address.city,
        'state': address.state,
      };
}
