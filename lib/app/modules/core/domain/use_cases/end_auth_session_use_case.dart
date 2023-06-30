import '../services/auth_session_service.dart';

class EndAuthSessionUseCase {
  EndAuthSessionUseCase(this._authSessionService);

  final AuthSessionService _authSessionService;

  Future<void> call() async => _authSessionService.endSession();
}
