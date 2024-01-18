import 'package:banking_app/data/remote/dto/request/register_goal.dart';
import 'package:banking_app/data/remote/dto/response/generic_response.dart';
import 'package:banking_app/data/remote/dto/response/goal_response.dart';

abstract class GoalRepository {
  Future<GenericResponse> registerGoal(RegisterGoalRequest request);
  Future<GenericResponse> updateGoal(UpdateGoalRequest request);
  Future<GoalResponse> fetchGoalsByUser();
}
