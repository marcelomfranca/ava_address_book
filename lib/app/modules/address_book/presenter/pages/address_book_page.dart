import 'package:address_book/app/shared/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/core_app.dart';
import '../../../core/presenter/pages/base_page.dart';
import '../../domain/entities/address.dart';
import '../../domain/use_cases/read_address_book_use_case.dart';
import '../controllers/address_book/address_book_controller.dart';
import '../controllers/address_book/address_states.dart';
import '../widgets/address_card.dart';

class AddressBookPage extends StatefulWidget {
  const AddressBookPage({super.key});

  static String title = 'Endereços';

  @override
  State<AddressBookPage> createState() => _AddressBookPageState();
}

class _AddressBookPageState extends State<AddressBookPage> {
  final addressRegisterController = CoreApp.autoInjector.get<AddressBookController>();
  final addressBookUseCase = CoreApp.autoInjector.get<ReadAddressBookUseCase>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final scrollController = ScrollController();
  var addressList = <Address>[];

  @override
  void initState() {
    super.initState();

    readAddressBook();
  }

  void setFavorite(Address item) {
    // setState(() {
    //   if (item.isFavorite) return findAndUpdateItem(item);

    //   scrollController.animateTo(0, duration: const Duration(milliseconds: 600), curve: Curves.bounceInOut);

    //   if (selectedAddress != null) findAndUpdateItem(selectedAddress!);

    //   selectedAddress = item.copyWith(isFavorite: true);

    //   listItem.remove(item);
    //   listItem.insert(0, selectedAddress!);
    // });
  }

  void findAndUpdateItem(Address item, [bool isFavorite = false]) {
    // final indexWhere = listItem.indexWhere((element) => (element == item));

    // if (indexWhere > -1) {
    //   listItem[indexWhere] = item.copyWith(isFavorite: isFavorite);
    // }
  }

  void readAddressBook() => addressRegisterController.readAddressBook();

  @override
  Widget build(BuildContext context) {
    return BasePage(
      scaffoldKey: scaffoldKey,
      title: AddressBookPage.title,
      showAppBar: true,
      withDrawer: true,
      padding: EdgeInsets.zero,
      floatingActionButton: SizedBox(
        width: 50,
        height: 50,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () => context.push('/addressForm').then((value) => readAddressBook()),
            tooltip: 'Adicionar endereço',
            child: const Icon(Icons.add),
          ),
        ),
      ),
      child: Column(
        children: [
          // ConstrainedBox(
          //   constraints: const BoxConstraints(maxWidth: 380),
          //   child: Padding(
          //     padding: const EdgeInsets.all(15),
          //     child: CustomFormTextField(
          //       hintText: 'Pesquisar',
          //       keyboardType: TextInputType.streetAddress,
          //       suffixIcon: Material(
          //         clipBehavior: Clip.hardEdge,
          //         color: Colors.transparent,
          //         borderRadius: BorderRadius.circular(100),
          //         child: ClipRRect(
          //           borderRadius: BorderRadius.circular(100),
          //           child: InkWell(
          //             child: const Icon(Icons.search, size: 14),
          //             onTap: () {},
          //           ),
          //         ),
          //       ),
          //       onChanged: (value) => addressRegisterController.search(value, addressList),
          //     ),
          //   ),
          // ),
          Expanded(
            child: BlocBuilder<AddressBookController, AddressBookState>(
              bloc: addressRegisterController,
              builder: (context, state) {
                if (state is LoadingAddressBookState) {
                  if (addressList.isEmpty) {
                    return const LoadingIndicator(backgroundColor: Colors.transparent, color: Color(0xFF20C9A7));
                  }
                }

                if (state is LoadedAddressBookState) {
                  addressList = List.from(state.addressList);
                }

                if (addressList.isEmpty) {
                  return const Center(
                    child: Text('Nenhum endereço cadastrado.'),
                  );
                }

                return ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 50),
                  itemCount: addressList.length,
                  itemBuilder: (context, index) {
                    final item = addressList[index];

                    return Padding(
                      key: ObjectKey(item),
                      padding: const EdgeInsets.symmetric(vertical: 7.5),
                      child: AddressCard(
                        address: item,
                        onTap: () => context.push('/addressForm', extra: item).then((value) => readAddressBook()),
                        onFavorite: setFavorite,
                        onDelete: (id) =>
                            addressRegisterController.deleteAddress(id).then((value) => readAddressBook()),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
