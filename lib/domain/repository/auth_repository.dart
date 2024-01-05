import 'package:banking_app/data/remote/dto/request/login_request.dart';
import 'package:banking_app/data/remote/dto/request/signup_request.dart';
import 'package:banking_app/data/remote/dto/response/generic_response.dart';
import 'package:banking_app/data/remote/dto/response/login_response.dart';

abstract class AuthRepository {
  Future<LoginResponse> login(LoginRequest loginRequest);
  Future<GenericResponse> signUp(SignupRequest signupRequest);
}
