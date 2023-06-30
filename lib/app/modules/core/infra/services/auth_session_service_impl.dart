import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../auth/domain/entities/user.dart';
import '../../../auth/infra/adapters/user_adapter.dart';
import '../../domain/services/auth_session_service.dart';

class AuthSessionServiceImpl extends AuthSessionService {
  AuthSessionServiceImpl._() {
    initialize();
  }

  static AuthSessionServiceImpl get instante => AuthSessionServiceImpl._();

  UserAva? _user;
  DateTime? _expiration;

  @override
  bool get isLogged => _user != null;

  @override
  UserAva? get currentUser => _user;

  @override
  Future<void> initialize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userMap = prefs.getString('user');

    if (userMap == null) return _user = null;

    _user = UserAdapter.fromMap(jsonDecode(userMap));
    _expiration = _user?.loggedAt?.add(const Duration(minutes: 30));
  }

  @override
  Future<void> startSession(UserAva user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    _expiration = user.loggedAt?.add(const Duration(minutes: 30));

    prefs.setString('user', jsonEncode(UserAdapter.toMap(user)));

    _user = user;

    notifyListeners();
  }

  @override
  Future<void> endSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('user');

    _user = null;

    notifyListeners();
  }

  @override
  bool validateUser() => _expiration?.isAfter(DateTime.now()) ?? false;
}
