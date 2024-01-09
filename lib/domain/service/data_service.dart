import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rxdart/rxdart.dart';

import '../../data/model/user.dart';

class DataService {
  final storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ));

  BehaviorSubject userData = BehaviorSubject<User>();

  Future<bool> isAuthenticated() async {
    return await storage.read(key: "access_token") != null;
  }
}
