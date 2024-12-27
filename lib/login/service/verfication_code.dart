import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kitob_ol/home/page/home.dart';
import 'package:kitob_ol/home/page/profile_edit.dart';
import 'package:kitob_ol/login/service/token.dart';

class VerificationPost {
  TokenStorage tokenStorage = TokenStorage();

  // Xato xabarlarini ko'rsatish
  void showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  String registerUrlNumber =
      "https://auth.axadjonovsardorbek.uz/auth/user/phone/register";
  String loginUrlNumber =
      "https://auth.axadjonovsardorbek.uz/auth/user/phone/login";

  String registerUrlEmail =
      "https://auth.axadjonovsardorbek.uz/auth/user/email/register";
  String loginUrlEmail =
      "https://auth.axadjonovsardorbek.uz/auth/user/email/login";

  // Email orqali login qilish
  Future<void> handleEmailLoginOrRegister(String emailNumber,
      String confirmationCode, BuildContext context, bool isEmail) async {
    try {
      Map<String, String> body = {
        "confirmation_code": confirmationCode,
        isEmail ? 'email' : "phone": "+998$emailNumber"
      };

      // Login uchun so'rov yuborish
      final response = await http.post(
        Uri.parse(isEmail ? loginUrlEmail : loginUrlNumber),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Login muvaffaqiyatli bo'lsa
        final responseData = jsonDecode(response.body);
        final token = responseData['access_token'];

        final tokenStorage = TokenStorage();
        await tokenStorage.saveToken(token);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        showErrorMessage(context, "Login qilish muvaffaqiyatli");
      } else {
        // Login muvaffaqiyatsiz bo'lsa, Registerni tekshirish
        final registerResponse = await http.post(
          Uri.parse(isEmail ? registerUrlEmail : registerUrlNumber),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body),
        );

        if (registerResponse.statusCode == 200 ||
            registerResponse.statusCode == 201) {
          final responseData = jsonDecode(registerResponse.body);
          final token = responseData['access_token'];

          final tokenStorage = TokenStorage();
          await tokenStorage.saveToken(token);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MyProfileEdit()),
          );
          showErrorMessage(context, "Ro'yxatdan o'tish muvaffaqiyatli");
        } else {
          // Agar login va register ham ishlamasa
          showErrorMessage(
              context, "Login va Register qilishda xatolik yuz berdi");
        }
      }
    } catch (e) {
      // Umumiy xato
      showErrorMessage(context, 'Xatolik yuz berdi: $e');
    }
  }

  // Tokenni olish (TokenStorage dan)
  Future<String?> getToken() async {
    final tokenStorage = TokenStorage();
    return tokenStorage.getToken(); // Tokenni TokenStorage dan oling
  }
}
