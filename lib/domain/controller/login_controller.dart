import 'package:banking_app/domain/repository/auth_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../data/remote/dto/request/login_request.dart';
import '../../ui/screens/auth/login/login_state.dart';

class LoginController {
  final AuthRepository _authRepository;

  LoginController(this._authRepository);

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
    if (email == null || password == null) {
      throw ArgumentError('Email and password must not be null');
    }

    final request = LoginRequest(
      email: email,
      password: password,
    );
    try {
      await _authRepository.login(request);
      String? token = await storage.read(key: 'access_token');
      print(token);
      return true;
    } catch (e) {
      print('Login error: $e');
      throw Exception('Login error: $e');
    }
  }
}
