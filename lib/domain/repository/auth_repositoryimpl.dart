import 'dart:convert';

import 'package:banking_app/data/remote/dto/request/signup_request.dart';
import 'package:banking_app/data/remote/dto/response/login_response.dart';
import 'package:banking_app/domain/repository/auth_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../data/remote/dto/request/login_request.dart';
import '../../data/remote/dto/response/generic_response.dart';
import '../../data/remote/infra/environment.dart';

class AuthRepositoryimpl implements AuthRepository {
  @override
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    const storage = FlutterSecureStorage();
    try {
      Response response = await http.post(
        endpoint,
        body: jsonEncode(loginRequest.toMap()),
      );
      if (response.statusCode == 200) {
        final resp = LoginResponse.fromJson(jsonDecode(response.body));
        await storage.write(key: 'access_token', value: resp.token);
        return resp;
      } else {
        throw Exception('Falha no login: ${response.body}');
      }
    } catch (e) {
      throw Exception('Falha no login: $e');
    }
  }

  @override
  Future<GenericResponse> signUp(SignupRequest signupRequest) async {
    try {
      var response = await http.post(
        endpoint,
        body: signupRequest.toMap(),
      );
      if (response.statusCode == 200) {
        var resp = GenericResponse.fromJson(jsonDecode(response.body));
        return resp.result;
      } else {
        throw Exception('Falha no login: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
