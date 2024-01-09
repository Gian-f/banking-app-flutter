import 'package:banking_app/data/remote/dto/request/signup_request.dart';
import 'package:banking_app/ui/screens/auth/signup/sign_up_state.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import '../repository/auth_repository.dart';

class SignUpController with ChangeNotifier {
  final AuthRepository _authRepository;

  SignUpController(this._authRepository);

  RegistrationUIState registrationUIState = RegistrationUIState();

  final allValidationsPassed = BehaviorSubject<bool>.seeded(false);

  final signUpInProgress = BehaviorSubject<bool>.seeded(false);

  Future<bool> onEvent(SignupUIEvent event) async {
    if (event is RegisterButtonClicked) {
      return _registerUser();
    } else {
      _updateRegistrationState(event);
      return false;
    }
  }

  void _updateRegistrationState(SignupUIEvent event) {
    if (event is FullNameChanged) {
      registrationUIState =
          registrationUIState.copyWith(fullName: event.fullName);
    } else if (event is EmailChanged) {
      registrationUIState = registrationUIState.copyWith(email: event.email);
    } else if (event is PhoneChanged) {
      registrationUIState =
          registrationUIState.copyWith(phoneNumber: event.phone);
    } else if (event is PasswordChanged) {
      registrationUIState =
          registrationUIState.copyWith(password: event.password);
    } else if (event is PrivacyPolicyCheckBoxClicked) {
      registrationUIState =
          registrationUIState.copyWith(privacyPolicyAccepted: event.status);
    }
    allValidationsPassed.add(_checkAllValidationsPassed());
    notifyListeners();
  }

  bool _checkAllValidationsPassed() {
    return registrationUIState.fullName?.isNotEmpty == true &&
        registrationUIState.email?.isNotEmpty == true &&
        registrationUIState.phoneNumber?.isNotEmpty == true &&
        registrationUIState.password?.isNotEmpty == true &&
        registrationUIState.privacyPolicyAccepted == true;
  }

  Future<bool> _registerUser() async {
    signUpInProgress.add(true);
    notifyListeners();

    final signUpRequest = SignupRequest(
      name: registrationUIState.fullName,
      email: registrationUIState.email,
      contactNumber: registrationUIState.phoneNumber,
      password: registrationUIState.password,
    );

    try {
      await _authRepository.registerUser(signUpRequest);
      allValidationsPassed.add(true);
      return Future.value(true);
    } catch (error) {
      allValidationsPassed.add(false);
      return Future.value(false);
    } finally {
      signUpInProgress.add(false);
      notifyListeners();
    }
  }
}
