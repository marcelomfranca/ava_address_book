import 'package:flutter/foundation.dart';

import '../../../core/domain/entities/base_registry.dart';

@immutable
class UserAva extends BaseRegistry {
  const UserAva({
    required super.id,
    required this.name,
    required this.email,
    this.favoriteAddress,
    this.loggedAt,
  });

  final String name;
  final String email;
  final int? favoriteAddress;
  final DateTime? loggedAt;
}
