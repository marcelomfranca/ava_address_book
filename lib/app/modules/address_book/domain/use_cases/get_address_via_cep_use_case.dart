import 'package:result_dart/result_dart.dart';

import '../../../../shared/errors/app_error.dart';
import '../../infra/dtos/via_cep_dto.dart';
import '../repositories/address_book_repository.dart';

class GetAddressViaCepUseCase {
  GetAddressViaCepUseCase(this._addressBookRepository);

  final AddressBookRepository _addressBookRepository;

  AsyncResult<ViaCepDto, AppException> call(String zipCOde) async => _addressBookRepository.getAddressViaCep(zipCOde);
}
