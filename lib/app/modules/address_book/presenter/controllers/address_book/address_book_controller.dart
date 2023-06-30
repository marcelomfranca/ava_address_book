import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core_app.dart';
import '../../../domain/use_cases/delete_address_use_case.dart';
import '../../../domain/use_cases/read_address_book_use_case.dart';
import 'address_states.dart';

class AddressBookController extends Cubit<AddressBookState> {
  AddressBookController(
    this._readAddressBookUseCase,
    this._deleteAddressUseCase,
  ) : super(const InitialAddressBookState());

  final ReadAddressBookUseCase _readAddressBookUseCase;
  final DeleteAddressUseCase _deleteAddressUseCase;

  Future<void> readAddressBook() async {
    emit(const LoadingAddressBookState());

    final userId = CoreApp.authSessionService.currentUser?.id;

    if (userId == null) return;

    final successOrFailure = await _readAddressBookUseCase(userId);

    emit(
      successOrFailure.fold(
        (success) => LoadedAddressBookState(addressList: success),
        (failure) => FailureAddressBookState(failure.message),
      ),
    );
  }

  Future<void> deleteAddress(int id) async {
    emit(const LoadingAddressBookState());

    final successOrFailure = await _deleteAddressUseCase(id);

    emit(
      successOrFailure.fold(
        (success) => const SuccessAddressBookState(),
        (failure) => FailureAddressBookState(failure.message),
      ),
    );
  }
}
