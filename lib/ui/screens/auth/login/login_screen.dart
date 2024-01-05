import 'package:banking_app/domain/controller/login_controller.dart';
import 'package:banking_app/domain/repository/auth_repositoryimpl.dart';
import 'package:banking_app/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

import '../../../../navigation.dart';
import '../../../widgets/form_widgets.dart';
import 'login_state.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  final LoginController loginController = LoginController(AuthRepositoryimpl());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  bool _isAuthenticating = false;

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
      });
      authenticated = await _localAuthentication.authenticate(
          authMessages: const <AuthMessages>[
            AndroidAuthMessages(
                signInTitle: 'Autenticação Biométrica',
                biometricHint: 'Entre usando sua biometria'),
            IOSAuthMessages(
              cancelButton: "Cancelar",
            ),
          ],
          localizedReason: ' ',
          options: const AuthenticationOptions(
              biometricOnly: false,
              useErrorDialogs: true,
              stickyAuth: true,
              sensitiveTransaction: true));
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
      });
      return;
    }
    if (!mounted) {
      return;
    }

    if (authenticated) {
      Navigator.pushReplacementNamed(context, '/home');
      showSnackbar(context, const Text("Sucesso!"));
    } else {
      // Autenticação falhou, mostrar mensagem de erro
      showSnackbar(context, const Text("Autenticação falhou"));
    }
  }

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
              FutureBuilder<bool>(
                future: widget.loginController.onEvent(LoginButtonClicked()),
                builder: (context, snapshot) {
                  return ButtonComponent(
                    isEnabled: true,
                    isLoading:
                        snapshot.connectionState == ConnectionState.waiting,
                    value: 'Entrar',
                    onButtonClicked: () {
                      onButtonClicked(context);
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              PasswordTextFieldComponent(
                labelValue: 'Senha',
                iconData: Icons.lock_outline,
                onTextSelected: (value) {
                  widget.loginController.onEvent(PasswordChanged(value));
                },
                validator: (value) {
                  return isPasswordValid(value);
                },
              ),
              const SizedBox(height: 20),
              ButtonComponent(
                isEnabled: true,
                isLoading: false,
                value: 'Entrar',
                onButtonClicked: () {
                  onButtonClicked(context);
                },
              ),
              const SizedBox(height: 20),
              const DividerTextComponent(),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  navigate(context, "/signup");
                },
                child: ClickableLoginTextComponent(
                  tryingToLogin: false,
                  onTextSelected: (string) {
                    navigate(context, "/signup");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onButtonClicked(BuildContext context) {
    widget.loginController.onEvent(LoginButtonClicked()).then((success) {
      if (success) {
        navigateFinish(context, "/home").whenComplete(() => showSnackbar(
            context, const Text("Operação realizada com sucesso!")));
      } else {
        showSnackbar(context, const Text("Erro: Falha no login"));
      }
    }).catchError((error) {
      if (error.toString().contains("SocketException")) {
        showSnackbar(context,
            const Text("Ocorreu um erro. Tente novamente mais tarde!"));
      } else {
        showSnackbar(context, Text("Erro: $error"));
      }
    });
  }

  isEmailValid(String? value) {
    if (value == null || value.isEmpty) {
      return showSnackbar(
          context, const Text('Por favor, preencha o campo de e-mail'));
    }
    Pattern pattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,6}$';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value)) {
      return showSnackbar(
          context, const Text('Por favor, insira um e-mail válido'));
    }
    return null;
  }

  isPasswordValid(String? value) {
    if (value == null || value.isEmpty) {
      return showSnackbar(
          context, const Text("Por favor, preencha o campo de senha"));
    }
    if (value.length < 3) {
      return showSnackbar(
          context, const Text("A senha deve ter pelo menos 3 caracter"));
    }
    return null;
  }
}
