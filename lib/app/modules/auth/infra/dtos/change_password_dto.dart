class ChangePasswordDto {
  const ChangePasswordDto({
    required this.password,
    required this.newPassword,
    required this.confirmPassword,
  });

  final String password;
  final String newPassword;
  final String confirmPassword;
}
