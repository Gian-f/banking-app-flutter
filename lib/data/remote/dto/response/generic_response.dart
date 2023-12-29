class GenericResponse {
  final dynamic result;
  final String message;
  final bool status;

  GenericResponse(
      {required this.result, required this.message, required this.status});
}
