class GenericResponse {
  final dynamic result;
  final int statusCode;
  final String message;
  final bool status;

  GenericResponse(
      {required this.result,
      required this.statusCode,
      required this.message,
      required this.status});

  static GenericResponse fromJson(Map<String, dynamic> json) {
    return GenericResponse(
      result: json['result'],
      statusCode: json['statusCode'],
      message: json['message'],
      status: json['status'],
    );
  }
}
