import 'dart:convert';

import 'package:banking_app/data/remote/dto/request/signup_request.dart';
import 'package:banking_app/data/remote/dto/response/login_response.dart';
import 'package:banking_app/domain/repository/auth_repository.dart';
import 'package:http/http.dart' as http;

import '../../data/di/module.dart';
import '../../data/remote/dto/request/login_request.dart';
import '../../data/remote/dto/response/generic_response.dart';
import '../../data/remote/infra/environment.dart';
import '../service/data_service.dart';

class AuthRepositoryimpl implements AuthRepository {
  @override
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    final DataService dataService = getIt<DataService>();

    try {
      var response = await http.post(
        loginEndpoint,
        body: jsonEncode(loginRequest.toMap()),
      );
      if (response.statusCode == 200) {
        final resp = LoginResponse.fromJson(jsonDecode(response.body));
        await dataService.storage.write(key: 'access_token', value: resp.token);
        return resp;
      } else {
        throw Exception('Falha no login: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GenericResponse> registerUser(SignupRequest signupRequest) async {
    try {
      var response = await http.post(
        registerEndpoint,
        body: jsonEncode(signupRequest.toMap()),
      );
      if (response.statusCode == 201) {
        final resp = GenericResponse.fromJson(jsonDecode(response.body));
        return resp;
      } else {
        throw Exception('Falha no login: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
