import 'package:address_book/app/modules/address_book/domain/use_cases/update_address_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/create_address_use_case.dart';
import '../../../domain/use_cases/get_address_via_cep_use_case.dart';
import '../../../infra/dtos/address_book_dto.dart';
import 'address_register_states.dart';

class AddressRegisterController extends Cubit<AddressRegisterState> {
  AddressRegisterController(
    this._createAddressUseCase,
    this._getAddressViaCepUseCase,
    this._updateAddressUseCase,
  ) : super(const InitialAddressRegisterState());

  final CreateAddressUseCase _createAddressUseCase;
  final GetAddressViaCepUseCase _getAddressViaCepUseCase;
  final UpdateAddressUseCase _updateAddressUseCase;

  Future<void> createAddress(AddressBookDto addressBookDto) async {
    emit(const RegisteringAddressState());

    final successOrFailure = await _createAddressUseCase(addressBookDto);

    emit(
      successOrFailure.fold(
        (success) => const RegisteredAddressState(),
        (failure) => AddressRegistrationFailureState(failure),
      ),
    );
  }

  Future<void> getCepInfo(String zipCode) async {
    emit(const GettingCepInfoState());

    final successOrFailure = await _getAddressViaCepUseCase(zipCode);

    emit(successOrFailure.fold((success) => CepInfoState(success), (failure) => GetCepInfoFailureState(failure)));
  }

  Future<void> updateAddress(AddressBookDto addressBookDto) async {
    emit(const RegisteringAddressState());

    final successOrFailure = await _updateAddressUseCase(addressBookDto);

    emit(
      successOrFailure.fold(
        (success) => const RegisteredAddressState(),
        (failure) => AddressRegistrationFailureState(failure),
      ),
    );
  }
}
