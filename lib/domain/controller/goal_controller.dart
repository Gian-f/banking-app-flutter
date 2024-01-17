import 'package:banking_app/data/remote/dto/request/register_goal.dart';
import 'package:banking_app/domain/repository/goal_repository.dart';
import 'package:flutter/material.dart';

import '../../data/di/module.dart';
import '../../data/model/goal.dart';
import '../service/data_service.dart';

class GoalController extends ChangeNotifier {
  final GoalRepository _goalRepository;
  DataService dataService = getIt<DataService>();

  GoalController(this._goalRepository);

  ValueNotifier<List<Goal?>> goals = ValueNotifier<List<Goal?>>(List.empty());

  Future<bool> registerGoal(RegisterGoalRequest newGoal) {
    try {
      _goalRepository.registerGoal(newGoal);
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }

  Future<bool> fetchAllGoals() async {
    try {
      if (dataService.goals.isEmpty || dataService.goals != goals) {
        await _goalRepository
            .fetchGoalsByUser()
            .then((value) => goals.value = value.result);
      } else {
        goals.value = dataService.goals;
      }
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }
}
