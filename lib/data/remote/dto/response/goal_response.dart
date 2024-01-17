import '../../../model/goal.dart';

class GoalResponse {
  final List<Goal> result;
  final int statusCode;
  final String message;
  final bool status;

  GoalResponse(
      {required this.result,
      required this.statusCode,
      required this.message,
      required this.status});

  static GoalResponse fromJson(Map<String, dynamic> json) {
    var list = json['result'] as List;
    List<Goal> goals = list.map((item) => Goal.fromJson(item)).toList();

    return GoalResponse(
      result: goals,
      statusCode: json['status_code'],
      message: json['message'],
      status: json['status'],
    );
  }
}
