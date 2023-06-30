import 'package:flutter/foundation.dart';

import '../../../auth/domain/entities/user.dart';

abstract class AuthSessionService extends ChangeNotifier {
  bool get isLogged;
  UserAva? get currentUser;

  Future<void> initialize();
  Future<void> startSession(UserAva user);
  Future<void> endSession();
  bool validateUser();
}
