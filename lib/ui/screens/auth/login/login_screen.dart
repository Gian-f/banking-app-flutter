import 'package:banking_app/domain/controller/login_controller.dart';
import 'package:banking_app/main.dart';
import 'package:banking_app/ui/screens/auth/signup/sign_up_screen.dart';
import 'package:flutter/material.dart';

import '../../../../navigation.dart';
import '../../../widgets/form_widgets.dart';
import 'login_state.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final LoginController loginController = LoginController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const HeadingTextComponent(value: 'Entrar'),
              const SizedBox(height: 20),
              MyTextFieldComponent(
                labelValue: 'E-mail',
                iconData: Icons.email_outlined,
                onTextChanged: (value) {
                  loginController.onEvent(EmailChanged(value));
                },
              ),
              const SizedBox(height: 20),
              PasswordTextFieldComponent(
                labelValue: 'Senha',
                iconData: Icons.lock_outline,
                onTextSelected: (value) {
                  loginController.onEvent(PasswordChanged(value));
                },
              ),
              const SizedBox(height: 20),
              ButtonComponent(
                isEnabled: true,
                value: 'Entrar',
                onButtonClicked: () {
                  loginController.onEvent(LoginButtonClicked());
                  navigate(context, const MyHomePage());
                },
              ),
              const SizedBox(height: 20),
              const DividerTextComponent(),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  navigate(context, const MyHomePage());
                },
                child: ClickableLoginTextComponent(
                  tryingToLogin: false,
                  onTextSelected: (string) {
                    navigate(context, SignUpScreen());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
