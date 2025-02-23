import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  String? _refreshToken;

  String? get token => _token;
  String? get refreshToken => _refreshToken;

  Future<void> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('access_token');
    _refreshToken = prefs.getString('refresh_token');
    notifyListeners(); // UI yangilanishi uchun
  }

  Future<void> saveToken(String newToken, String newRefreshToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', newToken);
    await prefs.setString('refresh_token', newRefreshToken);
    _token = newToken;
    _refreshToken = newRefreshToken;
    notifyListeners();
  }

  Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
    _token = null;
    _refreshToken = null;
    notifyListeners();
  }
}
