import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rxdart/rxdart.dart';

import '../../data/model/user.dart';

class DataService {
  final storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ));

  final _userDataSubject = BehaviorSubject<User>();

  Stream<User?> get userDataStream => _userDataSubject.stream;

  User? userData;

  DataService._internal();

  static final DataService _singleton = DataService._internal();

  factory DataService() {
    return _singleton;
  }

  void updateUserData(User newData) {
    userData = newData;
    _userDataSubject.add(newData);
  }

  Future<bool> isAuthenticated() async {
    return await storage.read(key: "access_token") != null;
  }
}
