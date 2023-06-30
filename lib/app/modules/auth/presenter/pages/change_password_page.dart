import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/widgets/base_button.dart';
import '../../../../shared/widgets/custom_alert_dialog.dart';
import '../../../../shared/widgets/form_fields/password_form_field.dart';
import '../../../../shared/widgets/loading_indicator.dart';
import '../../../core/core_app.dart';
import '../../../core/presenter/pages/base_page.dart';
import '../../infra/dtos/user_dto.dart';
import '../../infra/validators/user_dto_validator.dart';
import '../controllers/password/password_controller.dart';
import '../controllers/password/password_states.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  static String title = 'Cadastre-se';

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> with UserDtoValidate {
  final formKey = GlobalKey<FormState>();
  final changePasswordController = CoreApp.autoInjector.get<ChangePasswordController>();
  final fieldPasswordController = TextEditingController();
  final fieldNewPasswordController = TextEditingController();
  final fieldPasswordConfirmController = TextEditingController();

  void validateForm() {
    final validated = formKey.currentState?.validate() ?? false;

    final user = CoreApp.authSessionService.currentUser;
    final newPassword = fieldNewPasswordController.text;
    final currentPassword = fieldPasswordController.text;

    if (user == null) return;
    if (newPassword == currentPassword) return;

    if (validated) {
      final userDto = UserDto(
        id: user.id,
        email: user.email,
        name: user.name,
        loggedAt: user.loggedAt,
        password: newPassword,
        currentPassword: currentPassword,
      );

      changePasswordController.updateUserPassword(userDto);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Alterar senha',
      padding: EdgeInsets.zero,
      showAppBar: true,
      overlay: BlocConsumer<ChangePasswordController, PasswordState>(
        bloc: changePasswordController,
        listener: (context, state) {
          if (state is InvalidPasswordState) {
            showDialog(
                context: context, builder: (BuildContext context) => CustomAlertDialog(text: state.error.message));
          } else if (state is PasswordChangedState) {
            showDialog(
              context: context,
              builder: (BuildContext context) => CustomAlertDialog(
                text: 'Senha alterada, faça login novamente.',
                actions: [
                  TextButton(onPressed: () => CoreApp.authSessionService.endSession(), child: const Text('OK'))
                ],
              ),
              barrierDismissible: false,
            );
          }
        },
        builder: (context, state) {
          return Visibility(visible: (state is ChangingPasswordState), child: const LoadingIndicator());
        },
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  PasswordFormField(
                    title: 'Senha',
                    hintText: 'Digite sua senha atual',
                    controller: fieldPasswordController,
                    confirmController: fieldNewPasswordController,
                    validator: changePasswordValidate,
                  ),
                  const SizedBox(height: 20),
                  PasswordFormField(
                    title: 'Nova senha',
                    hintText: 'Digite a nova senha',
                    controller: fieldNewPasswordController,
                    confirmController: fieldPasswordConfirmController,
                    validator: passwordValidate,
                  ),
                  const SizedBox(height: 10),
                  PasswordFormField(
                    title: 'Confirmar nova senha',
                    hintText: 'Digite a senha novamente',
                    controller: fieldPasswordConfirmController,
                    confirmController: fieldNewPasswordController,
                    validator: passwordValidate,
                  ),
                  const SizedBox(height: 30),
                  BlocBuilder<ChangePasswordController, PasswordState>(
                    bloc: changePasswordController,
                    builder: (context, state) {
                      var onTap = true;
                      var actionText = 'Salvar';

                      if ((state is ChangingPasswordState)) {
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
