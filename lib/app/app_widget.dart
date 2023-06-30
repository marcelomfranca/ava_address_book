import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

import 'modules/core/core_app.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  GoRouter get router => CoreApp.instance.router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Address Book',
      restorationScopeId: 'AppWidget',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF20C9A7),
        brightness: Brightness.light,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF21CBA6)),
        ),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 2.5),
          hintStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
          fillColor: Colors.white70,
          filled: true,
          errorStyle: const TextStyle(height: 0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32), borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32), borderSide: BorderSide.none),
          disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32), borderSide: BorderSide.none),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32), borderSide: const BorderSide(color: Colors.red)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32), borderSide: const BorderSide(color: Color(0xFF21CBA6))),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32), borderSide: const BorderSide(color: Colors.red)),
        ),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
    );
  }
}
