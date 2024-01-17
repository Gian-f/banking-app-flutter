import 'package:banking_app/domain/controller/goal_controller.dart';
import 'package:banking_app/domain/repository/goal_repositoryimpl.dart';
import 'package:banking_app/domain/repository/user_repositoryimpl.dart';
import 'package:get_it/get_it.dart';

import '../../domain/controller/home_controller.dart';
import '../../domain/controller/profile_controller.dart';
import '../../domain/repository/home_repositoryimpl.dart';
import '../../domain/service/data_service.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => DataService());
  getIt.registerLazySingleton(() => HomeController(HomeRepositoryimpl()));
  getIt.registerLazySingleton(() => GoalController(GoalRepositoryimpl()));
  getIt.registerLazySingleton(
      () => ProfileController(HomeRepositoryimpl(), UserRepositoryImpl()));
}
