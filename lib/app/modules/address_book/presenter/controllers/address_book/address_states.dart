import '../../../domain/entities/address.dart';

sealed class AddressBookState {
  const AddressBookState();
}

class InitialAddressBookState extends AddressBookState {
  const InitialAddressBookState();
}

class LoadingAddressBookState extends AddressBookState {
  const LoadingAddressBookState();
}

class LoadedAddressBookState extends AddressBookState {
  const LoadedAddressBookState({required this.addressList});

  final List<Address> addressList;
}

class SuccessAddressBookState extends AddressBookState {
  const SuccessAddressBookState();
}

class FailureAddressBookState extends AddressBookState {
  const FailureAddressBookState(this.message);

  final String message;
}
