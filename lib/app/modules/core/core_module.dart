import 'package:auto_injector/auto_injector.dart';
import 'package:go_router/go_router.dart';

import 'domain/interfaces/module.dart';
import 'domain/services/auth_session_service.dart';
import 'domain/use_cases/end_auth_session_use_case.dart';
import 'domain/use_cases/start_auth_session_use_case.dart';
import 'infra/services/auth_session_service_impl.dart';
import 'presenter/pages/about_page.dart';
import 'presenter/pages/splash_page.dart';

class CoreModule implements Module {
  @override
  String get name => 'Core';

  @override
  AutoInjector get injector => AutoInjector(
        tag: 'CoreModule',
        on: (i) {
          i.addInstance<AuthSessionService>(AuthSessionServiceImpl.instante);
          i.addSingleton<StartAuthSessionUseCase>(StartAuthSessionUseCase.new);
          i.addSingleton<EndAuthSessionUseCase>(EndAuthSessionUseCase.new);
        },
      );

  @override
  List<GoRoute> get routes => [
        GoRoute(
          name: 'splash',
          path: '/splash',
          builder: (context, state) => const SplashPage(),
        ),
        GoRoute(
          name: 'about',
          path: '/about',
          builder: (context, state) => const AboutPage(),
        ),
      ];

  @override
  List<Map<String, dynamic>> get sqlScript => [];
}
