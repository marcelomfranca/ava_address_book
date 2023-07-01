import 'package:auto_injector/auto_injector.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sqflite/sqflite.dart';

import '../../app_module.dart';
import '../address_book/address_module.dart';
import '../auth/auth_module.dart';
import 'core_module.dart';
import 'domain/interfaces/module.dart';
import 'domain/services/auth_session_service.dart';
import 'helpers/sqflite_helper.dart';

class CoreApp {
  CoreApp._() {
    _initializeInjector();
    _initializeRouter();
  }

  static const databaseName = 'AVAAddressBook.db';

  static final CoreApp instance = CoreApp._();
  static final modules = [AppModule(), CoreModule(), AuthModule(), AddressModule()];
  static final autoInjector = AutoInjector();
  static final navigatorKey = GlobalKey<NavigatorState>();
  static final authSessionService = autoInjector.get<AuthSessionService>();

  Future<Database> get dataBase async => await initializeDataBase();

  late final GoRouter router;

  Future<void> initialize() async => await Future.delayed(const Duration(seconds: 4));

  void _initializeInjector() {
    for (Module module in modules) {
      autoInjector.addInjector(module.injector);
    }

    autoInjector.commit();
  }

  void _initializeRouter() {
    debugPrint('registerRoutes');

    if (modules.isEmpty) throw Exception('No module registered.');

    final routes = <GoRoute>[];

    for (Module module in modules) {
      routes.addAll(module.routes);
    }

    router = GoRouter(
      refreshListenable: authSessionService,
      navigatorKey: navigatorKey,
      initialLocation: '/addressBook',
      routes: routes,
      redirect: (context, state) {
        final isLogged = authSessionService.isLogged;
        final validated = authSessionService.validateUser();
        final isExternalRoute = (state.extra == true);

        if (isExternalRoute) return null;

        if (!isLogged || !validated) {
          return state.namedLocation('login');
        }

        return null;
      },
    );
  }

  static Future<Database> initializeDataBase() async {
    try {
      final db = await SQFLiteConfig.initialize((db, version) async {
        for (var module in modules) {
          if (module.sqlScript.isEmpty) continue;

          debugPrint(module.name);

          for (var sql in module.sqlScript) {
            if ((sql['version'] == version)) {
              await db.execute(sql['sql']);
            }
          }
        }
      }, (db, oldVersion, version) async {
        if (oldVersion < version) {
          for (var module in modules) {
            if (module.sqlScript.isEmpty) continue;

            debugPrint(module.name);

            for (var sql in module.sqlScript) {
              if ((sql['version'] == version) && sql['type'] == 'upgrade') {
                await db.execute(sql['sql']);
              }
            }
          }
        }
      }, databaseName);

      return db;
    } catch (e) {
      rethrow;
    }
  }
}
