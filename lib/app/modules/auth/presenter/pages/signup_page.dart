import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/base_button.dart';
import '../../../../shared/widgets/custom_alert_dialog.dart';
import '../../../../shared/widgets/form_fields/custom_text_form_field.dart';
import '../../../../shared/widgets/form_fields/email_form_field.dart';
import '../../../../shared/widgets/form_fields/password_form_field.dart';
import '../../../../shared/widgets/loading_indicator.dart';
import '../../../core/core_app.dart';
import '../../../core/presenter/pages/base_page.dart';
import '../../../core/presenter/widgets/logo.dart';
import '../../infra/dtos/user_dto.dart';
import '../../infra/validators/user_dto_validator.dart';
import '../controllers/signup/signup_states.dart';
import '../controllers/signup/sigup_controller.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  static String title = 'Cadastre-se';

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> with UserDtoValidate {
  final formKey = GlobalKey<FormState>();
  final signUpController = CoreApp.autoInjector.get<SignUpController>();
  final fieldNameController = TextEditingController();
  final fieldEMailController = TextEditingController();
  final fieldPasswordController = TextEditingController();
  final fieldPasswordConfirmController = TextEditingController();

  void validateForm() {
    final validated = formKey.currentState?.validate() ?? false;

    if (validated) {
      final userDto = UserDto(
        name: fieldNameController.text,
        email: fieldEMailController.text,
        password: fieldPasswordController.text,
      );

      signUpController.createUser(userDto);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Cadastre-se',
      showAppBar: false,
      overlay: BlocConsumer<SignUpController, SignUpState>(
        bloc: signUpController,
        listener: (context, state) {
          if (state is UserRegistrationFailureState) {
            showDialog(context: context, builder: (BuildContext context) => CustomAlertDialog(text: state.message));
          } else if (state is RegisteredUserState) {
            context.go('/addressBook');
          }
        },
        builder: (context, state) {
          return Visibility(visible: (state is RegisteringUserState), child: const LoadingIndicator());
        },
      ),
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 300),
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    const Logo(),
                    const SizedBox(height: 20),
                    const Text('Preencha os campos e crie uma conta.'),
                    const SizedBox(height: 20),
                    CustomFormTextField(
                      title: 'Nome',
                      controller: fieldNameController,
                      hintText: 'Digite seu nome',
                      keyboardType: TextInputType.name,
                      validator: nameValidate,
                    ),
                    const SizedBox(height: 5),
                    EmailFormField(
                      title: 'E-Mail',
                      controller: fieldEMailController,
                      validator: emailValidate,
                      onFocusChangeValidate: signUpController.checkEmail,
                    ),
                    const SizedBox(height: 5),
                    PasswordFormField(
                      title: 'Senha',
                      controller: fieldPasswordController,
                      confirmController: fieldPasswordConfirmController,
                      validator: passwordValidate,
                    ),
                    const SizedBox(height: 5),
                    PasswordFormField(
                      title: 'Confirmar senha',
                      hintText: 'Digite a senha novamente',
                      controller: fieldPasswordConfirmController,
                      confirmController: fieldPasswordController,
                      validator: passwordValidate,
                    ),
                    const SizedBox(height: 25),
                    BlocBuilder<SignUpController, SignUpState>(
                      bloc: signUpController,
                      builder: (context, state) {
                        var onTap = true;
                        var actionText = 'Criar minha conta';

                        if ((state is CheckingEmailState)) {
                          onTap = false;
                          actionText = 'Verificando email';
                        } else if (state is RegisteringUserState) {
                          onTap = false;
                          actionText = 'Aguarde';
                        }

                        return Column(
                          children: <Widget>[
                            ConstrainedBox(
                              constraints: const BoxConstraints(minHeight: 50),
                              child: Center(child: BaseButton(text: actionText, onTap: onTap ? validateForm : null)),
                            ),
                            const SizedBox(height: 15),
                            BaseButton(text: 'Voltar', onTap: () => context.go('/login')),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
