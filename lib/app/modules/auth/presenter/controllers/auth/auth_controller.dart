import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/login_use_case.dart';
import '../../../infra/dtos/user_dto.dart';
import 'auth_states.dart';

class AuthController extends Cubit<AuthState> {
  AuthController(this._loginUseCase) : super(const InitialAuthState());

  final LoginUseCase _loginUseCase;

  Future<void> login(UserDto dto) async {
    emit(const GettingInState());

    final successOrFailure = await _loginUseCase(dto);

    emit(successOrFailure.fold((success) => LoggedState(success), (failure) => AuthFailureState(failure)));
  }
}
