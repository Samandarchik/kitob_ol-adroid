import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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

  Future<String> updateToken() async {
    String updateTokenURL =
        "https://gateway.axadjonovsardorbek.uz/auth/refresh";

    try {
      final response = await http.post(
        Uri.parse(updateTokenURL),
        headers: {'Authorization': 'Bearer $_token'},
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        String newToken = jsonData['access_token'];
        String newRefreshToken = jsonData['refresh_token'];

        await saveToken(newToken, newRefreshToken);
        return newToken; // Yangi token qaytariladi
      } else {
        throw Exception('Token yangilanmadi! Status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Xatolik yuz berdi: $e');
    }
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token') ?? '';
  }
}
