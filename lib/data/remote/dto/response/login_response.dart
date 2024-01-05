class LoginResponse {
  final dynamic token;
  final int statusCode;
  final String message;
  final bool status;

  LoginResponse(
      {required this.token,
      required this.statusCode,
      required this.message,
      required this.status});

  static LoginResponse fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'],
      statusCode: json['status_code'],
      message: json['message'],
      status: json['status'],
    );
  }
}
