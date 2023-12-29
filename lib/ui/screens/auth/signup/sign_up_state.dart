class RegistrationUIState {
  String? firstName;
  String? email;
  String? phoneNumber;
  String? password;
  bool? privacyPolicyAccepted;
  bool? firstNameError;
  bool? emailError;
  bool? passwordError;
  bool? phoneError;
  bool? privacyPolicyError;

  RegistrationUIState({
    this.firstName,
    this.email,
    this.phoneNumber,
    this.password,
    this.privacyPolicyAccepted,
    this.firstNameError,
    this.emailError,
    this.passwordError,
    this.phoneError,
    this.privacyPolicyError,
  });

  RegistrationUIState copyWith({
    String? firstName,
    String? email,
    String? phoneNumber,
    String? password,
    bool? privacyPolicyAccepted,
    bool? firstNameError,
    bool? emailError,
    bool? passwordError,
    bool? phoneError,
    bool? privacyPolicyError,
  }) {
    return RegistrationUIState(
      firstName: firstName ?? this.firstName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      privacyPolicyAccepted:
          privacyPolicyAccepted ?? this.privacyPolicyAccepted,
      firstNameError: firstNameError ?? this.firstNameError,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      phoneError: phoneError ?? this.phoneError,
      privacyPolicyError: privacyPolicyError ?? this.privacyPolicyError,
    );
  }
}

abstract class SignupUIEvent {}

class FirstNameChanged extends SignupUIEvent {
  final String firstName;

  FirstNameChanged(this.firstName);
}

class EmailChanged extends SignupUIEvent {
  final String email;

  EmailChanged(this.email);
}

class PhoneChanged extends SignupUIEvent {
  final String phone;

  PhoneChanged(this.phone);
}

class PasswordChanged extends SignupUIEvent {
  final String password;

  PasswordChanged(this.password);
}

class PrivacyPolicyCheckBoxClicked extends SignupUIEvent {
  final bool status;

  PrivacyPolicyCheckBoxClicked(this.status);
}

class RegisterButtonClicked extends SignupUIEvent {}
