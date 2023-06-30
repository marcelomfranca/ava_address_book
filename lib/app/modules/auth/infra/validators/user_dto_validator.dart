import '../../../core/domain/exceptions/validate_exception.dart';

mixin class UserDtoValidate {
  void nameValidate(String name) {
    if (name.isEmpty) {
      throw ValidateException('name', 'O nome não pode ser vazio');
    }
  }

  void emailValidate(String email) {
    if (email.isEmpty) {
      throw ValidateException('email', 'O email não pode ser vazio');
    }

    final regexp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!regexp.hasMatch(email)) {
      throw ValidateException('email', 'O email está inválido');
    }
  }

  void changePasswordValidate(String password, [String? newPassword]) {
    if (password.length < 6) {
      throw ValidateException('password', 'A senha deve conter no mínimo 6 caracteres');
    }

    if (password == newPassword) {
      throw ValidateException('changePasswordValidate', 'A nova senha deve ser diferente da atual');
    }
  }

  void passwordValidate(String password, [String? confirm]) {
    if (password.length < 6) {
      throw ValidateException('password', 'A senha deve conter no mínimo 6 caracteres');
    }

    if (confirm == null) return;

    if (password != confirm) {
      throw ValidateException('passwordConfirm', 'As senhas não conferem');
    }
  }
}
