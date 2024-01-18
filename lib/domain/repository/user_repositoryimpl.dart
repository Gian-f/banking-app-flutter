import 'dart:convert';

import 'package:banking_app/data/remote/dto/request/update_user_request.dart';
import 'package:banking_app/data/remote/dto/response/user_response.dart';
import 'package:banking_app/domain/repository/user_repository.dart';
import 'package:http/http.dart' as http;

import '../../data/di/module.dart';
import '../../data/remote/infra/environment.dart';
import '../service/data_service.dart';

class UserRepositoryImpl implements UserRepository {
  final DataService dataService = getIt<DataService>();

  @override
  Future<UpdateUserResponse> updateUserData(
      UpdateUserRequest updateUserRequest) async {
    final token = await dataService.storage.read(key: "access_token");
    try {
      var response = await http.put(userEndpoint,
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(updateUserRequest.toMap()));
      if (response.statusCode == 200) {
        final resp = UpdateUserResponse.fromJson(jsonDecode(response.body));
        return resp;
      } else {
        throw Exception('Falha ao atualizar usuário: ${response.body}');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
