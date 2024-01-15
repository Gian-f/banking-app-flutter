import 'dart:convert';

import 'package:banking_app/data/remote/dto/response/user_response.dart';
import 'package:banking_app/domain/repository/home_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../data/di/module.dart';
import '../../data/remote/infra/environment.dart';
import '../service/data_service.dart';

class HomeRepositoryimpl implements HomeRepository {
  final DataService dataService = getIt<DataService>();
  final storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ));

  @override
  Future<UserResponse> fetchUserData() async {
    final token = await storage.read(key: "access_token");
    try {
      var response = await http.get(
        userEndpoint,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final resp = UserResponse.fromJson(jsonDecode(response.body));
        dataService.updateUserData(resp.result);
        return resp;
      } else {
        throw Exception('Falha no login: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
