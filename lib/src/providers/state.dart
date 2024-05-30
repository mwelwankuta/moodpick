import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _storage = FlutterSecureStorage();

class AuthenticationProvider with ChangeNotifier {
  var _isAuthenticated = false;
  var _email = "";

  Future<void> setAuthenticated(email) async {
    _email = email;
    _isAuthenticated = true;

    await _storage.write(key: 'email', value: email);
  }

  Future<void> logOut() async {
    _isAuthenticated = false;
    _email = "";
    await _storage.delete(key: 'email');
  }

  bool get isAuthenticated {
    return _isAuthenticated;
  }

  String get email {
    return _email;
  }
}
