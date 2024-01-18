import 'package:banking_app/data/remote/dto/request/update_user_request.dart';

import '../../data/remote/dto/response/user_response.dart';

abstract class UserRepository {
  Future<UpdateUserResponse> updateUserData(
      UpdateUserRequest updateUserRequest);
}
