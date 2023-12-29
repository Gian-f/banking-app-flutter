import 'dart:async';

import '../../ui/screens/auth/login/login_state.dart';

class LoginController {
  final _loginStateController = StreamController<bool>();
  Stream<bool> get loginError => _loginStateController.stream;

  final _passwordStateController = StreamController<bool>();
  Stream<bool> get passwordError => _passwordStateController.stream;

  final _loginInProgressController = StreamController<bool>();
  Stream<bool> get loginInProgress => _loginInProgressController.stream;

  final _loginUIStateController = StreamController<LoginUIState>();
  Stream<LoginUIState> get loginUIState => _loginUIStateController.stream;

  void onEvent(LoginUIEvent event) {
    switch (event.runtimeType) {
      case EmailChanged:
        _handleEmailChanged(event as EmailChanged);
        break;
      case PasswordChanged:
        _handlePasswordChanged(event as PasswordChanged);
        break;
      case LoginButtonClicked:
        _handleLoginButtonClicked();
        break;
      default:
        throw UnsupportedError('Unsupported event: $event');
    }
  }

  void _handleEmailChanged(EmailChanged event) {
    _loginUIStateController.add(LoginUIState(login: event.email));
  }

  void _handlePasswordChanged(PasswordChanged event) {
    _loginUIStateController.add(LoginUIState(password: event.password));
  }

  void _handleLoginButtonClicked() {
    _loginInProgressController.add(true);
  }

  void dispose() {
    _loginStateController.close();
    _passwordStateController.close();
    _loginInProgressController.close();
    _loginUIStateController.close();
  }
}

class LoginUIState {
  final String login;
  final String password;

  LoginUIState({this.login = '', this.password = ''});
}
