import 'package:banking_app/ui/screens/auth/signup/sign_up_state.dart';
import 'package:flutter/foundation.dart';

class SignUpController with ChangeNotifier {
  RegistrationUIState registrationUIState = RegistrationUIState();
  bool allValidationsPassed = false;
  bool signUpInProgress = false;

  void onEvent(SignupUIEvent event) {
    if (event is FirstNameChanged) {
      registrationUIState =
          registrationUIState.copyWith(firstName: event.firstName);
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
    } else if (event is RegisterButtonClicked) {
      // Implement signUp logic here
    }
    validateDataWithRules();
  }

  void validateDataWithRules() {
    // Implement validation logic here
  }
}
