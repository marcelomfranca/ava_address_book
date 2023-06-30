import 'package:auto_injector/auto_injector.dart';
import 'package:go_router/go_router.dart';

abstract interface class Module {
  String get name;
  AutoInjector get injector;
  List<GoRoute> get routes;
  List<Map<String, dynamic>> get sqlScript;
}
