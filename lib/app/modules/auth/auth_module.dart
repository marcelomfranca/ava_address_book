import 'package:address_book/app/modules/auth/presenter/pages/change_password_page.dart';

import 'domain/use_cases/login_use_case.dart';
import 'external/data_sources/login_sqflite_data_source_impl.dart';
import 'infra/data_sources/login_sqflite_data_source.dart';

import 'package:auto_injector/auto_injector.dart';
import 'package:go_router/go_router.dart';

import '../address_book/external/data_sources/get_address_via_cep_data_source_impl.dart';
import '../address_book/infra/data_sources/get_address_via_cep_data_source.dart';
import '../core/domain/interfaces/module.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/use_cases/check_email_use_case.dart';
import 'domain/use_cases/create_user_use_case.dart';
import 'domain/use_cases/update_user_password_use_case.dart';
import 'external/data_sources/check_email_sqflite_data_source_impl.dart';
import 'external/data_sources/create_user_sqflite_data_source_impl.dart';
import 'external/data_sources/update_password_sqflite_data_source_impl.dart';
import 'infra/data_sources/check_email_sqflite_data_source.dart';
import 'infra/data_sources/create_user_sqflite_data_source.dart';
import 'infra/data_sources/update_user_password_sqflite_data_source.dart';
import 'infra/repositories/auth_repository_impl.dart';
import 'presenter/controllers/auth/auth_controller.dart';
import 'presenter/controllers/password/password_controller.dart';
import 'presenter/controllers/signup/sigup_controller.dart';
import 'presenter/pages/login_page.dart';
import 'presenter/pages/signup_page.dart';

class AuthModule implements Module {
  @override
  String get name => 'Login';

  @override
  AutoInjector get injector => AutoInjector(
        tag: 'LoginModule',
        on: (i) {
          // Data Sources
          i.addLazySingleton<LoginSQFLiteDataSource>(LoginSQFLiteDataSourceImpl.new);
          i.addLazySingleton<CheckEmailSQFLiteDataSource>(CheckEmailSQFLiteDataSourceImpl.new);
          i.addLazySingleton<GetAddressViaCepDataSource>(GetAddressViaCepDataSourceImpl.new);
          i.addLazySingleton<CreateUserSQFLiteDataSource>(CreateUserSQFLiteDataSourceImpl.new);
          i.addLazySingleton<UpdateUserPasswordSQFLiteDataSource>(UpdatePasswordSQFLiteDataSourceImpl.new);
          // Repository
          i.addLazySingleton<AuthRepository>(AuthRepositoryImpl.new);
          // Use Cases
          i.addLazySingleton<LoginUseCase>(LoginUseCase.new);
          i.addLazySingleton<CheckEmailUseCase>(CheckEmailUseCase.new);
          i.addLazySingleton<CreateUserUseCase>(CreateUserUseCase.new);
          i.addLazySingleton<UpdateUserPasswordUseCase>(UpdateUserPasswordUseCase.new);
          // Controllers
          i.add(AuthController.new);
          i.add(SignUpController.new);
          i.add(ChangePasswordController.new);
        },
      );

  @override
  List<GoRoute> get routes => [
        GoRoute(
          name: 'login',
          path: '/login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          name: 'register',
          path: '/register',
          builder: (context, state) => const SignupPage(),
        ),
        GoRoute(
          name: 'changePassword',
          path: '/changePassword',
          builder: (context, state) => const ChangePasswordPage(),
        ),
      ];

  @override
  List<Map<String, dynamic>> get sqlScript => [
        {
          'version': 1,
          'type': 'upgrade',
          'sql': '''CREATE TABLE Users (id INTEGER PRIMARY KEY AUTOINCREMENT,
                      name TEXT NOT NULL,
                      email INTEGER NOT NULL,
                      password TEXT NOT NULL,
                      favoriteAddress INTEGER,
                      loggedAt TEXT) '''
        }
      ];
}
