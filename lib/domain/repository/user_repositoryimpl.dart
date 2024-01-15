import 'dart:convert';

import 'package:banking_app/data/remote/dto/request/update_user_request.dart';
import 'package:banking_app/data/remote/dto/response/user_response.dart';
import 'package:banking_app/domain/repository/user_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../data/di/module.dart';
import '../../data/remote/infra/environment.dart';
import '../service/data_service.dart';

class UserRepositoryImpl implements UserRepository {
  final DataService dataService = getIt<DataService>();
  final storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ));

  @override
  Future<UserResponse> updateUserData(
      UpdateUserRequest updateUserRequest) async {
    final token = await storage.read(key: "access_token");
    try {
      var response = await http.put(userEndpoint,
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(updateUserRequest.toMap()));
      if (response.statusCode == 200) {
        final resp = UserResponse.fromJson(jsonDecode(response.body));
        return resp;
      } else {
        throw Exception('Falha ao atualizar usuário: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }
}