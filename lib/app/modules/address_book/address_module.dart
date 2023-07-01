import 'package:auto_injector/auto_injector.dart';
import 'package:go_router/go_router.dart';

import '../core/domain/interfaces/module.dart';
import 'domain/entities/address.dart';
import 'domain/repositories/address_book_repository.dart';
import 'domain/use_cases/create_address_use_case.dart';
import 'domain/use_cases/delete_address_use_case.dart';
import 'domain/use_cases/get_address_via_cep_use_case.dart';
import 'domain/use_cases/read_address_book_use_case.dart';
import 'domain/use_cases/update_address_use_case.dart';
import 'external/data_sources/create_address_sqflite_data_source_impl.dart';
import 'external/data_sources/delete_address_sqflite_data_source_impl.dart';
import 'external/data_sources/get_address_via_cep_data_source_impl.dart';
import 'external/data_sources/read_address_book_sqflite_data_source_impl.dart';
import 'external/data_sources/update_address_sqflite_data_source_impl.dart';
import 'infra/data_sources/create_address_sqflite_data_source.dart';
import 'infra/data_sources/delete_address_sqflite_data_source.dart';
import 'infra/data_sources/get_address_via_cep_data_source.dart';
import 'infra/data_sources/read_address_book_sqflite_data_source.dart';
import 'infra/data_sources/update_address_sqflite_data_source.dart';
import 'infra/repositories/address_book_repository_impl.dart';
import 'presenter/controllers/address_book/address_book_controller.dart';
import 'presenter/controllers/address_register/address_register_controller.dart';
import 'presenter/pages/address_book_page.dart';
import 'presenter/pages/address_form_page.dart';

class AddressModule implements Module {
  @override
  String get name => 'Address book';

  @override
  AutoInjector get injector => AutoInjector(
        tag: 'AddressModule',
        on: (i) {
          // Data Sources
          i.addLazySingleton<CreateAddressSQFLiteDataSource>(CreateAddressSQFLiteDataSourceImpl.new);
          i.addLazySingleton<ReadAddressBookSQFLiteDataSource>(ReadAddressBookSQFLiteDataSourceImpl.new);
          i.addLazySingleton<UpdateAddressSQFLiteDataSource>(UpdateAddressSQFLiteDataSourceImpl.new);
          i.addLazySingleton<DeleteAddressSQFLiteDataSource>(DeleteAddressSQFLiteDataSourceImpl.new);
          i.addLazySingleton<GetAddressViaCepDataSource>(GetAddressViaCepDataSourceImpl.new);
          // Repository
          i.addLazySingleton<AddressBookRepository>(AddressBookRepositoryImpl.new);
          // Use Cases
          i.addLazySingleton<CreateAddressUseCase>(CreateAddressUseCase.new);
          i.addLazySingleton<ReadAddressBookUseCase>(ReadAddressBookUseCase.new);
          i.addLazySingleton<UpdateAddressUseCase>(UpdateAddressUseCase.new);
          i.addLazySingleton<DeleteAddressUseCase>(DeleteAddressUseCase.new);
          i.addLazySingleton<GetAddressViaCepUseCase>(GetAddressViaCepUseCase.new);
          // Controllers
          i.add(AddressBookController.new);
          i.add(AddressRegisterController.new);
        },
      );

  @override
  List<GoRoute> get routes => [
        GoRoute(
          name: 'addressBook',
          path: '/addressBook',
          builder: (context, state) => const AddressBookPage(),
        ),
        GoRoute(
          name: 'addressForm',
          path: '/addressForm',
          builder: (context, state) =>
              AddressFormPage(address: (state.extra != null) ? (state.extra! as Address) : null),
        ),
      ];

  @override
  List<Map<String, dynamic>> get sqlScript => [
        {
          'version': 1,
          'type': 'create',
          'sql': '''CREATE TABLE AddressBook (id INTEGER PRIMARY KEY AUTOINCREMENT,
                      userId INTEGER NOT NULL,
                      title TEXT,
                      zipCode INTEGER NOT NULL,
                      streetAddress TEXT NOT NULL,
                      streetAddressNumber INTEGER NOT NULL,
                      additionalAddress TEXT,
                      district TEXT NOT NULL,
                      city TEXT NOT NULL,
                      state TEXT NOT NULL) '''
        },
      ];
}
