import 'dart:core';

class SignupRequest {
  late final String name;
  late final String email;
  late final String phone;
  late final String password;

  SignupRequest(
      {required this.name,
      required this.email,
      required this.phone,
      required this.password});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    };
  }
}
