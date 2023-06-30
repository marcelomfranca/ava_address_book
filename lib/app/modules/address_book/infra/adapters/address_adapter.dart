import '../../domain/entities/address.dart';

abstract class AddressAdapter {
  AddressAdapter._();

  static Address fromMap(Map<String, dynamic> map) {
    return Address(
      id: map['id'],
      title: map['title'],
      zipCode: map['zipCode'].toString(),
      streetAddress: map['streetAddress'],
      streetAddressNumber: map['streetAddressNumber'].toString(),
      additionalAddress: map['additionalAddress'],
      district: map['district'],
      city: map['city'],
      state: map['state'],
    );
  }

  static List<Address> fromMapList(List list) {
    if (list.isEmpty) return [];

    return list.map<Address>((address) => fromMap(address)).toList();
  }

  static Map<String, dynamic> toMap(Address address) => {
        'id': address.id,
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
