import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/base_button.dart';
import '../../../../shared/widgets/custom_alert_dialog.dart';
import '../../../../shared/widgets/form_fields/custom_text_form_field.dart';
import '../../../../shared/widgets/form_fields/zip_code_form_field.dart';
import '../../../../shared/widgets/loading_indicator.dart';
import '../../../core/core_app.dart';
import '../../../core/infra/themes/styles.dart';
import '../../../core/presenter/pages/base_page.dart';
import '../../domain/entities/address.dart';
import '../../infra/dtos/address_book_dto.dart';
import '../../infra/dtos/via_cep_dto.dart';
import '../../infra/validators/address_dto_validator.dart';
import '../controllers/address_register/address_register_controller.dart';
import '../controllers/address_register/address_register_states.dart';

class AddressFormPage extends StatefulWidget {
  const AddressFormPage({super.key, this.address});

  final Address? address;

  static String title = 'Novo endereço';

  @override
  State<AddressFormPage> createState() => _AddressFormPageState();
}

class _AddressFormPageState extends State<AddressFormPage> with AddressDtoValidate {
  final addressRegisterController = CoreApp.autoInjector.get<AddressRegisterController>();
  final formKey = GlobalKey<FormState>();
  final fieldTitleController = TextEditingController();
  final fieldZipCodeController = TextEditingController();
  final fieldStreetAddressController = TextEditingController();
  final fieldNumberController = TextEditingController();
  final fieldAdditionalAddressController = TextEditingController();
  final fieldDistrictController = TextEditingController();
  final fieldCityController = TextEditingController();
  final fieldStateController = TextEditingController();

  @override
  void initState() {
    super.initState();

    populateForm();
  }

  void validateForm() {
    final validated = formKey.currentState?.validate() ?? false;

    final userId = CoreApp.authSessionService.currentUser?.id;

    if (userId == null) return context.go('/login');

    if (validated) {
      final userDto = AddressBookDto(
        id: widget.address?.id,
        userId: userId,
        title: fieldTitleController.text.trim(),
        zipCode: fieldZipCodeController.text.trim(),
        streetAddress: fieldStreetAddressController.text.trim(),
        streetAddressNumber: fieldNumberController.text.trim(),
        additionalAddress: fieldAdditionalAddressController.text.trim(),
        district: fieldDistrictController.text.trim(),
        city: fieldCityController.text.trim(),
        state: fieldStateController.text.trim(),
      );

      if (widget.address != null) {
        addressRegisterController.updateAddress(userDto);
      } else {
        addressRegisterController.createAddress(userDto);
      }
    }
  }

  void populateFormWithViaCep(ViaCepDto viaCepDto) {
    fieldZipCodeController.text = viaCepDto.cep.replaceAll(RegExp('[^0-9]'), '');
    fieldStreetAddressController.text = viaCepDto.streetAddress;
    fieldAdditionalAddressController.text = viaCepDto.additionalAddress;
    fieldDistrictController.text = viaCepDto.district;
    fieldCityController.text = viaCepDto.city;
    fieldStateController.text = viaCepDto.state;
  }

  void clearFormWithViaCep() {
    fieldStreetAddressController.text = '';
    fieldAdditionalAddressController.text = '';
    fieldDistrictController.text = '';
    fieldCityController.text = '';
    fieldStateController.text = '';
  }

  void populateForm() {
    final address = widget.address;

    if (address != null) {
      fieldTitleController.text = address.title;
      fieldZipCodeController.text = address.zipCode.replaceAll(RegExp('[^0-9]'), '');
      fieldStreetAddressController.text = address.streetAddress;
      fieldNumberController.text = address.streetAddressNumber;
      fieldAdditionalAddressController.text = address.additionalAddress;
      fieldDistrictController.text = address.district;
      fieldCityController.text = address.city;
      fieldStateController.text = address.state;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Novo endereço',
      showAppBar: true,
      padding: EdgeInsets.zero,
      overlay: BlocConsumer<AddressRegisterController, AddressRegisterState>(
        bloc: addressRegisterController,
        listener: (context, state) {
          if (state is AddressRegistrationFailureState) {
            showDialog(
                context: context, builder: (BuildContext context) => CustomAlertDialog(text: state.error.message));
          } else if (state is RegisteredAddressState) {
            context.pop();
          }
        },
        builder: (context, state) {
          return Visibility(visible: (state is RegisteringAddressState), child: const LoadingIndicator());
        },
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 30),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Form(
              key: formKey,
              child: BlocConsumer<AddressRegisterController, AddressRegisterState>(
                bloc: addressRegisterController,
                listener: (context, state) {
                  if (state is CepInfoState) return populateFormWithViaCep(state.data);
                  if (state is GetCepInfoFailureState) return clearFormWithViaCep();
                },
                builder: (context, state) {
                  final waitingCepInfo = (state is GettingCepInfoState);

                  return Column(
                    children: <Widget>[
                      const SizedBox(height: 10),
                      const Text('Preencha os campos para adicionar um novo endereço.'),
                      const SizedBox(height: 20),
                      CustomFormTextField(
                        title: 'Título',
                        hintText: 'Ex.: Casa',
                        controller: fieldTitleController,
                        keyboardType: TextInputType.streetAddress,
                      ),
                      const SizedBox(height: 5),
                      ZipCodeFormField(
                        title: 'CEP',
                        controller: fieldZipCodeController,
                        onFocusChangeValidate: addressRegisterController.getCepInfo,
                        validator: cepValidate,
                      ),
                      Builder(
                        builder: (context) {
                          return Visibility(
                            visible: (state is GettingCepInfoState),
                            child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
                                child: Text('Aguarde, buscando cep', style: StylesAVA.infoTextField),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 5),
                      CustomFormTextField(
                        title: 'Endereço',
                        hintText: 'Digite o endereço',
                        controller: fieldStreetAddressController,
                        keyboardType: TextInputType.streetAddress,
                        validator: streetAddressValidate,
                        readOnly: waitingCepInfo,
                      ),
                      const SizedBox(height: 5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: 90,
                            child: CustomFormTextField(
                              title: 'Número',
                              hintText: 'Número',
                              controller: fieldNumberController,
                              textAlign: TextAlign.center,
                              maxLength: 6,
                              keyboardType: TextInputType.number,
                              validator: streetAddressNumberValidate,
                              showErrorText: false,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomFormTextField(
                              title: 'Complemento',
                              hintText: 'Digite o complemento',
                              controller: fieldAdditionalAddressController,
                              readOnly: waitingCepInfo,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      CustomFormTextField(
                        title: 'Bairro',
                        hintText: 'Digite o bairro',
                        controller: fieldDistrictController,
                        validator: districtValidate,
                        readOnly: waitingCepInfo,
                      ),
                      const SizedBox(height: 5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: CustomFormTextField(
                              title: 'Cidade',
                              hintText: 'Digite a cidade',
                              controller: fieldCityController,
                              validator: cityValidate,
                              readOnly: waitingCepInfo,
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 60,
                            child: CustomFormTextField(
                              title: 'UF',
                              hintText: 'UF',
                              controller: fieldStateController,
                              textAlign: TextAlign.center,
                              inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))],
                              maxLength: 2,
                              onChanged: (value) => fieldStateController.value = TextEditingValue(
                                  text: value.toUpperCase(), selection: fieldStateController.selection),
                              validator: stateValidate,
                              readOnly: waitingCepInfo,
                              showErrorText: false,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Builder(
                        builder: (context) {
                          var onTap = true;
                          var actionText = 'Salvar';

                          if ((state is RegisteringAddressState) || (state is GettingCepInfoState)) {
                            onTap = false;
                            actionText = 'Aguarde';
                          }

                          return Column(
                            children: <Widget>[
                              ConstrainedBox(
                                constraints: const BoxConstraints(minHeight: 50),
                                child: Center(child: BaseButton(text: actionText, onTap: onTap ? validateForm : null)),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
