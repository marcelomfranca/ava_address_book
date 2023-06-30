import '../../domain/entities/user.dart';

abstract class UserAdapter {
  UserAdapter._();

  static UserAva fromMap(Map<String, dynamic> map, {DateTime? loggedAt}) {
    return UserAva(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      favoriteAddress: map['favoriteAddress'],
      loggedAt: loggedAt ?? DateTime.tryParse(map['loggedAt'] ?? ''),
    );
  }

  static Map<String, dynamic> toMap(UserAva user) => {
        'id': user.id,
        'name': user.name,
        'email': user.email,
        'favoriteAddress': user.favoriteAddress,
        'loggedAt': user.loggedAt.toString(),
      };
}
