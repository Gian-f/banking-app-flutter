import '../../../model/user.dart';

class UserResponse {
  final User result;
  final int statusCode;
  final String message;
  final bool status;

  UserResponse(
      {required this.result,
      required this.statusCode,
      required this.message,
      required this.status});

  static UserResponse fromJson(Map<String, dynamic> json) {
    return UserResponse(
      result: User.fromJson(json['result']),
      statusCode: json['status_code'],
      message: json['message'],
      status: json['status'],
    );
  }
}
