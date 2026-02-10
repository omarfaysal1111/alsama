import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import 'dart:convert';

abstract class AuthLocalDataSource {
  Future<void> cacheToken(String token);
  Future<String?> getToken();
  Future<void> clearToken();
  Future<void> cacheUser(UserModel user);
  Future<UserModel?> getCachedUser();
  Future<void> clearUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences _prefs;
  
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'cached_user';

  AuthLocalDataSourceImpl({required SharedPreferences prefs}) : _prefs = prefs;

  @override
  Future<void> cacheToken(String token) async {
    await _prefs.setString(_tokenKey, token);
  }

  @override
  Future<String?> getToken() async {
    return _prefs.getString(_tokenKey);
  }

  @override
  Future<void> clearToken() async {
    await _prefs.remove(_tokenKey);
  }

  @override
  Future<void> cacheUser(UserModel user) async {
    final jsonString = json.encode(user.toJson());
    await _prefs.setString(_userKey, jsonString);
  }

  @override
  Future<UserModel?> getCachedUser() async {
    final jsonString = _prefs.getString(_userKey);
    if (jsonString != null) {
      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      return UserModel.fromJson(jsonMap);
    }
    return null;
  }

  @override
  Future<void> clearUser() async {
    await _prefs.remove(_userKey);
  }
}
