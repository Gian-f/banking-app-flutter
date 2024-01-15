import '../../data/remote/dto/response/user_response.dart';

abstract class HomeRepository {
  Future<UserResponse> fetchUserData();
}
