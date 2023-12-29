abstract class LoginUIEvent {}

class EmailChanged extends LoginUIEvent {
  final String email;

  EmailChanged(this.email);
}

class PasswordChanged extends LoginUIEvent {
  final String password;

  PasswordChanged(this.password);
}

class LoginButtonClicked extends LoginUIEvent {}

class DismissError extends LoginUIEvent {}
