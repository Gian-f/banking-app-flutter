import '../../../model/user.dart';

class UserResponse {
  final dynamic result;
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

class UpdateUserResponse {
  final dynamic result;
  final int statusCode;
  final String message;
  final bool status;

  UpdateUserResponse(
      {required this.result,
      required this.statusCode,
      required this.message,
      required this.status});

  static UpdateUserResponse fromJson(Map<String, dynamic> json) {
    return UpdateUserResponse(
      result: json['result'],
      statusCode: json['status_code'],
      message: json['message'],
      status: json['status'],
    );
  }
}
