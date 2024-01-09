import 'package:banking_app/domain/repository/auth_repository.dart';
import 'package:banking_app/domain/service/data_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../data/remote/dto/request/login_request.dart';
import '../../ui/screens/auth/login/login_state.dart';

class LoginController {
  final AuthRepository _authRepository;
  final DataService dataService;

  LoginController(this._authRepository, this.dataService);

  final storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ));

  String email = "";
  String password = "";

  Future<bool> onEvent(LoginUIEvent event) async {
    switch (event.runtimeType) {
      case EmailChanged:
        email = (event as EmailChanged).email;
        break;
      case PasswordChanged:
        password = (event as PasswordChanged).password;
        break;
      case LoginButtonClicked:
        return await _login(email, password);
      default:
        throw UnsupportedError('Unsupported event: $event');
    }
    return false;
  }

  Future<bool> _login(String? email, String? password) async {
    if (email!.isEmpty || password!.isEmpty) {
      throw Exception('E-mail ou senha não podem ser vazios!');
    }

    final request = LoginRequest(
      email: email.trim(),
      password: password.trim(),
    );
    try {
      await _authRepository.login(request);
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }
}
