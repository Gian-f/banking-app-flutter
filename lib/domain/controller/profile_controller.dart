import 'package:banking_app/data/remote/dto/request/update_user_request.dart';
import 'package:banking_app/domain/repository/user_repository.dart';
import 'package:banking_app/ui/screens/profile/profile_state.dart';
import 'package:flutter/cupertino.dart';

import '../../data/di/module.dart';
import '../../data/model/user.dart';
import '../repository/home_repository.dart';
import '../service/data_service.dart';

class ProfileController extends ChangeNotifier {
  final HomeRepository _homeRepository;
  final UserRepository _userRepository;

  ProfileController(this._homeRepository, this._userRepository);

  DataService dataService = getIt<DataService>();

  ValueNotifier<User?> user = ValueNotifier<User?>(User(
      name: "Carregando...",
      email: "Carregando...",
      photo: "Carregando...",
      contact_number: "Carregando..."));

  Future<void> fetchUserData() async {
    if (dataService.userData == null) {
      _homeRepository
          .fetchUserData()
          .then((value) => user.value = value.result);
    } else {
      user.value = dataService.userData;
    }
  }

  Future<void> onEvent(ProfileUIEvent event) async {
    switch (event.runtimeType) {
      case FullNameChanged:
        user.value?.name = (event as FullNameChanged).fullName;
        break;
      case PhoneChanged:
        user.value?.contact_number = (event as PhoneChanged).phone;
        break;
      case PhotoChanged:
        user.value?.photo = (event as PhotoChanged).photo;
        break;
      case UpdateUserButtonClicked:
        final updatedUser = UpdateUserRequest(
            name: user.value!.name,
            contactNumber: user.value!.contact_number,
            photo: user.value!.photo!);
        return await _updateUserData(updatedUser);
      default:
        throw UnsupportedError('Unsupported event: $event');
    }
  }

  Future<void> _updateUserData(UpdateUserRequest user) async {
    await _userRepository.updateUserData(user);
  }
}
