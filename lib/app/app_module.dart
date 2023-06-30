import 'package:auto_injector/auto_injector.dart';
import 'package:go_router/go_router.dart';

import 'modules/core/domain/interfaces/module.dart';

mixin class AppModule implements Module {
  @override
  String get name => 'AVA Address Book';

  @override
  final routes = <GoRoute>[];

  @override
  List<Map<String, dynamic>> get sqlScript => [];

  @override
  AutoInjector get injector => AutoInjector(
        tag: 'AppModule',
        on: (i) {},
      );
}
