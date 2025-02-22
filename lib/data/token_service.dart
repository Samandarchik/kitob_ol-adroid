import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  /// Tokenlarni saqlash
  Future<void> saveTokens(
      String accessToken, String refreshToken, String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', accessToken);
    await prefs.setString('refreshToken', refreshToken);
    await prefs.setString('role', role);
  }

  /// Saqlangan tokenlarni o'qish
  Future<Map<String, String?>> getTokens() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'accessToken': prefs.getString('accessToken'),
      'refreshToken': prefs.getString('refreshToken'),
      'role': prefs.getString('role'),
    };
  }

  /// Tokenlarni o'chirish
  Future<void> removeTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    await prefs.remove('refreshToken');
    await prefs.remove('role');
  }

  /// Login funksiyasi: backendga yuboradi va tokenlarni qaytaradi
  Future<Map<String, String>?> login(String emailOrNumber, String code) async {
    final url =
        Uri.parse("https://auth.axadjonovsardorbek.uz/auth/user/email/login");

    final payload = {
      "confirmation_code": code,
      "email": emailOrNumber,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return {
          'accessToken': data['access_token'], // To'g'ri field nomini ishlating
          'refreshToken': data['refresh_token'],
          'role': data['role'],
        };
      } else {
        throw Exception("Xato: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      rethrow;
    }
  }
}
