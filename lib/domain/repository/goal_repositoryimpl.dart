import 'dart:convert';

import 'package:banking_app/data/remote/dto/request/register_goal.dart';
import 'package:banking_app/data/remote/dto/response/goal_response.dart';
import 'package:http/http.dart' as http;

import '../../data/di/module.dart';
import '../../data/remote/dto/response/generic_response.dart';
import '../../data/remote/infra/environment.dart';
import '../service/data_service.dart';
import 'goal_repository.dart';

class GoalRepositoryimpl implements GoalRepository {
  final DataService dataService = getIt<DataService>();

  @override
  Future<GenericResponse> registerGoal(RegisterGoalRequest request) async {
    final token = await dataService.storage.read(key: "access_token");
    try {
      var response = await http.post(goalEndpoint,
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(request.toMap()));
      if (response.statusCode == 201) {
        final resp = GenericResponse.fromJson(jsonDecode(response.body));
        return resp;
      } else {
        throw Exception('Falha ao cadastrar objetivo: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GoalResponse> fetchGoalsByUser() async {
    final token = await dataService.storage.read(key: "access_token");
    try {
      var response = await http.get(
        goalEndpoint,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final resp = GoalResponse.fromJson(jsonDecode(response.body));
        dataService.updateGoals(resp.result);
        return resp;
      } else {
        throw Exception('Falha ao buscar objetivos: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GenericResponse> updateGoal(UpdateGoalRequest request) async {
    final token = await dataService.storage.read(key: "access_token");
    try {
      var response = await http.put(goalEndpoint,
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(request.toMap()));
      if (response.statusCode == 200) {
        final resp = GenericResponse.fromJson(jsonDecode(response.body));
        return resp;
      } else {
        throw Exception('Falha ao editar objetivo: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
