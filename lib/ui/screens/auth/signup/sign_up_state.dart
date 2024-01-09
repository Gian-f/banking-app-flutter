class RegistrationUIState {
  String? fullName;
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
    this.fullName,
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
    String? fullName,
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
      fullName: fullName ?? this.fullName,
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

class FullNameChanged extends SignupUIEvent {
  final String fullName;

  FullNameChanged(this.fullName);
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
