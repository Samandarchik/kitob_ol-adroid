import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kitob_ol/home/page/home.dart';
import 'package:kitob_ol/login/page/verification_code.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  String registerUrlNumber =
      "https://auth.axadjonovsardorbek.uz/auth/sms/register/phone";
  String registerUrlEmail =
      "https://auth.axadjonovsardorbek.uz/auth/sms/register/email";
  String loginUrlPhone =
      "https://auth.axadjonovsardorbek.uz/auth/sms/login/phone";
  String loginUrlEmail =
      "https://auth.axadjonovsardorbek.uz/auth/sms/login/email";

  // Tokenni saqlash
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  // Tokenni o'qish
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // Tokenni o'chirish (Logout)
  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  // Telefon raqam bilan ro'yxatdan o'tish
  Future<void> registerUserNumber(String phone, BuildContext context) async {
    try {
      Map<String, String> body = {
        'phone': "+998$phone",
      };

      final response = await http.post(
        Uri.parse(registerUrlNumber),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 201) {
        var responseData = jsonDecode(response.body);
        if (responseData['message'] == 'Sms sent successfully') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerificationCode(
                isEmail: false,
                number: phone,
              ),
            ),
          );
        }
      } else if (response.statusCode == 400) {
        print("Telefon raqami allaqachon ro'yxatdan o'tgan.");
        var responseData = jsonDecode(response.body);
        if (responseData['message'] == 'such phone exists') {
          // Login qilish
          loginUserNumber(phone, context);
        }
      }
    } catch (e) {
      print("Xato: $e");
    }
  }

  // Telefon raqami bilan login qilish
  Future<void> loginUserNumber(String phone, BuildContext context) async {
    try {
      Map<String, String> body = {
        'phone': "+998$phone",
      };

      final response = await http.post(
        Uri.parse(loginUrlPhone),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        String token = responseData['token']; // Tokenni oling
        saveToken(token); // Tokenni saqlash
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        print("Login failed: ${response.statusCode}");
      }
    } catch (e) {
      print("Xato: $e");
    }
  }

  // Elektron pochta bilan login qilish
  Future<void> loginUserEmail(String email, BuildContext context) async {
    try {
      Map<String, String> body = {
        'email': email,
      };

      final response = await http.post(
        Uri.parse(loginUrlEmail),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        String token = responseData['token']; // Tokenni oling
        saveToken(token); // Tokenni saqlash
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        print("Login failed: ${response.statusCode}");
      }
    } catch (e) {
      print("Xato: $e");
    }
  }
}
