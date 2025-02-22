import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginService {
  Future<Map<String, String>?> login(
      bool isNumber, String email, String confirmationCode) async {
    String apiUrl =
        "https://auth.axadjonovsardorbek.uz/auth/user/${isNumber ? "phone" : "email"}/login";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'confirmation_code': confirmationCode,
          'email': email,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final accessToken = data['access_token'];
        final refreshToken = data['refresh_token'];
        final role = data['role'];

        if (accessToken != null && refreshToken != null) {
          return {
            'accessToken': accessToken,
            'refreshToken': refreshToken,
            'role': role,
          };
        } else {
          print("Tokenlar qaytmagan.");
        }
      } else {
        print("Login muvaffaqiyatsiz: ${response.body}");
      }
    } catch (error) {
      print("Xatolik yuz berdi: $error");
    }
    return null;
  }
}
