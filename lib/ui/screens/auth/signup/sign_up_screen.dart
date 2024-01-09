import 'package:banking_app/domain/controller/signup_controller.dart';
import 'package:banking_app/domain/service/data_service.dart';
import 'package:banking_app/navigation.dart';
import 'package:banking_app/ui/screens/auth/signup/sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../domain/repository/auth_repositoryimpl.dart';
import '../../../widgets/form_widgets.dart';
import '../../../widgets/widgets.dart';

class SignUpScreen extends StatelessWidget {
  final SignUpController signUpController =
      SignUpController(AuthRepositoryimpl(DataService()));

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const NormalTextComponent(
                  value: 'Olá',
                ),
                const HeadingTextComponent(value: "Registre-se"),
                const SizedBox(height: 20),
                MyTextFieldComponent(
                  labelValue: 'Nome completo',
                  iconData: Icons.person_outline,
                  onTextChanged: (value) {
                    signUpController.onEvent(FullNameChanged(value));
                  },
                  errorStatus:
                      signUpController.registrationUIState.firstNameError,
                  validator: (String) {},
                ),
                const SizedBox(height: 20),
                MyTextFieldComponent(
                  labelValue: 'E-mail',
                  iconData: Icons.email_outlined,
                  onTextChanged: (value) {
                    signUpController.onEvent(EmailChanged(value));
                  },
                  errorStatus: signUpController.registrationUIState.emailError,
                  validator: (String) {},
                ),
                const SizedBox(height: 20),
                PhoneTextFieldComponent(
                  labelValue: 'Telefone',
                  iconData: Icons.phone_android_outlined,
                  onTextChanged: (value) {
                    signUpController.onEvent(PhoneChanged(value));
                  },
                  errorStatus:
                      signUpController.registrationUIState.firstNameError,
                  validator: (String) {},
                ),
                const SizedBox(height: 20),
                PasswordTextFieldComponent(
                  labelValue: 'Senha',
                  iconData: Icons.lock_outline,
                  onTextSelected: (value) {
                    signUpController.onEvent(PasswordChanged(value));
                  },
                  errorStatus:
                      signUpController.registrationUIState.passwordError,
                  validator: (String) {},
                ),
                const SizedBox(height: 20),
                CheckboxComponent(
                  value:
                      'Ao continuar, você aceita nossa \n Política de Privacidade e Termos de Uso',
                  onCheckedChange: (value) {
                    signUpController
                        .onEvent(PrivacyPolicyCheckBoxClicked(value));
                  },
                  onTextSelected: (string) {},
                ),
                const SizedBox(height: 20),
                ButtonComponent(
                  value: 'Registrar',
                  isLoading: signUpController.signUpInProgress.value,
                  isEnabled: true,
                  onButtonClicked: () {
                    onButtonClicked(context);
                  },
                ),
                const SizedBox(height: 15),
                const DividerTextComponent(),
                const SizedBox(height: 15),
                ClickableLoginTextComponent(
                  tryingToLogin: true,
                  onTextSelected: (string) {
                    navigate(context, "/");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onButtonClicked(BuildContext context) {
    signUpController.onEvent(RegisterButtonClicked()).then((result) {
      if (result) {
        navigateFinish(context, "/");
        showSnackbar(context, const Text("Operação realizada com sucesso!"));
      } else {
        showSnackbar(context, const Text("Erro: Falha ao cadastrar usuário!"));
      }
    }).catchError((error) {
      if (error.toString().contains("Falha no login")) {
        showSnackbar(context,
            const Text("Ocorreu um erro. Tente novamente mais tarde!"));
      } else {
        showSnackbar(context, Text("$error"));
      }
    });
  }
}
