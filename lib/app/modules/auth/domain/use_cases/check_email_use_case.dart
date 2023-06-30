import 'package:result_dart/result_dart.dart';

import '../../../../shared/errors/app_error.dart';
import '../repositories/auth_repository.dart';

class CheckEmailUseCase {
  CheckEmailUseCase(this._authRepository);

  final AuthRepository _authRepository;

  AsyncResult<void, AppException> call(String email) async => _authRepository.checkEmail(email);
}
