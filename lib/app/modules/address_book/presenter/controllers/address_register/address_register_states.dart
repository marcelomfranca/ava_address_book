import '../../../infra/dtos/via_cep_dto.dart';
import '../../../../../shared/errors/app_error.dart';

import '../../../domain/entities/address.dart';

sealed class AddressRegisterState {
  const AddressRegisterState();
}

class InitialAddressRegisterState extends AddressRegisterState {
  const InitialAddressRegisterState();
}

class RegisteringAddressState extends AddressRegisterState {
  const RegisteringAddressState();
}

class RegisteredAddressState extends AddressRegisterState {
  const RegisteredAddressState();
}

class AddressListState extends AddressRegisterState {
  const AddressListState(this.adresses);

  final List<Address> adresses;
}

class GettingCepInfoState extends AddressRegisterState {
  const GettingCepInfoState();
}

class CepInfoState extends AddressRegisterState {
  const CepInfoState(this.data);

  final ViaCepDto data;
}

class GetCepInfoFailureState extends AddressRegisterState {
  const GetCepInfoFailureState(this.error);

  final AppException error;
}

class AddressRegistrationFailureState extends AddressRegisterState {
  const AddressRegistrationFailureState(this.error);

  final AppException error;
}
