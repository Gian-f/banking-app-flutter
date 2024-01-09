import 'dart:core';

class SignupRequest {
  late final String? name;
  late final String? email;
  late final String? contactNumber;
  late final String? password;

  SignupRequest(
      {required this.name,
      required this.email,
      required this.contactNumber,
      required this.password});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'contact_number': contactNumber,
      'password': password,
    };
  }
}
