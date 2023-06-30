import '../controllers/auth/auth_controller.dart';
import '../controllers/auth/auth_states.dart';
import '../../../core/core_app.dart';
import '../../../core/presenter/widgets/logo.dart';
import '../../../../shared/widgets/yes_or_no_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/base_button.dart';
import '../../../../shared/widgets/custom_alert_dialog.dart';
import '../../../../shared/widgets/form_fields/email_form_field.dart';
import '../../../../shared/widgets/form_fields/password_form_field.dart';
import '../../../../shared/widgets/loading_indicator.dart';
import '../../../core/presenter/pages/base_page.dart';
import '../../domain/exceptions/user_email_not_exists_exception.dart';
import '../../infra/dtos/user_dto.dart';
import '../../infra/validators/user_dto_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static String title = 'Login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with UserDtoValidate {
  final authController = CoreApp.autoInjector.get<AuthController>();
  final formKey = GlobalKey<FormState>();
  final fieldEMailController = TextEditingController();
  final fieldPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void validateForm() {
    final validated = formKey.currentState?.validate() ?? false;

    if (validated) {
      final userDto = UserDto(
        name: '',
        email: fieldEMailController.text,
        password: fieldPasswordController.text,
      );

      authController.login(userDto);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      showAppBar: false,
      overlay: BlocConsumer<AuthController, AuthState>(
        bloc: authController,
        listener: (context, state) {
          if (state is AuthFailureState) {
            if (state.error is UserEMailNotExistsException) {
              showDialog(
                context: context,
                builder: (BuildContext context) => YesOrNoDialog(
                  yesCallBack: context.pop,
                  noCallBack: () => context.go('/register', extra: true),
                  text: 'Usuário não cadastrado,\n deseja se cadastrar agora?',
                ),
              );
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) => CustomAlertDialog(text: state.error.message),
              );
            }
          } else if (state is LoggedState) {
            context.go('/addressBook');
          }
        },
        builder: (context, state) {
          return Visibility(visible: (state is GettingInState), child: const LoadingIndicator());
        },
      ),
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 30),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 300),
              child: Column(
                children: [
                  const Logo(animale: true),
                  const SizedBox(height: 20),
                  Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        EmailFormField(
                          title: 'E-Mail',
                          controller: fieldEMailController,
                          validator: emailValidate,
                        ),
                        const SizedBox(height: 10),
                        PasswordFormField(
                          title: 'Senha',
                          controller: fieldPasswordController,
                          validator: passwordValidate,
                        ),
                        const SizedBox(height: 25),
                        BlocBuilder<AuthController, AuthState>(
                          bloc: authController,
                          builder: (context, state) {
                            var onTap = true;

                            if ((state is GettingInState)) {
                              onTap = false;
                            }

                            return Column(
                              children: <Widget>[
                                ConstrainedBox(
                                  constraints: const BoxConstraints(minHeight: 50),
                                  child: Center(
                                    child: BaseButton(
                                      text: onTap ? 'Entrar' : 'Aguarde',
                                      onTap: onTap ? validateForm : null,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Não tem cadastro? ',
                        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                      ),
                      TextButton(
                        onPressed: () => context.go('/register', extra: true),
                        child: const Text(
                          'Cadastre-se agora!',
                          style: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 16, decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
