import 'package:banking_app/domain/repository/home_repository.dart';
import 'package:flutter/cupertino.dart';

import '../../data/di/module.dart';
import '../../data/model/user.dart';
import '../service/data_service.dart';

class HomeController extends ChangeNotifier {
  final HomeRepository _homeRepository;

  HomeController(this._homeRepository);

  DataService dataService = getIt<DataService>();

  ValueNotifier<User?> user = ValueNotifier<User?>(User(
      name: "Carregando...",
      email: "Carregando...",
      photo: "Carregando...",
      contact_number: "Carregando..."));

  Future<bool> fetchUserData() async {
    try {
      if (dataService.userData == null) {
        await _homeRepository
            .fetchUserData()
            .then((value) => user.value = value.result);
      } else {
        user.value = dataService.userData;
      }
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }
}
