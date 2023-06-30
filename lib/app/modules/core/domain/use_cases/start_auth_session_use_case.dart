import '../../../auth/domain/entities/user.dart';
import '../services/auth_session_service.dart';

class StartAuthSessionUseCase {
  StartAuthSessionUseCase(this._authSessionService);

  final AuthSessionService _authSessionService;

  Future<void> call(UserAva user) async => _authSessionService.startSession(user);
}
