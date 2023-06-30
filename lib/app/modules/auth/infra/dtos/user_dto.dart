class UserDto {
  UserDto({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    this.currentPassword,
    this.loggedAt,
  });

  final int? id;
  final String name;
  final String email;
  final String password;
  final String? currentPassword;
  final DateTime? loggedAt;

  factory UserDto.empty() => UserDto(name: '', email: '', password: '');

  UserDto copyWith({
    int? id,
    String? name,
    String? email,
    String? password,
    String? currentPassword,
    DateTime? loggedAt,
  }) {
    return UserDto(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      currentPassword: currentPassword ?? this.currentPassword,
      loggedAt: loggedAt ?? this.loggedAt,
    );
  }
}
