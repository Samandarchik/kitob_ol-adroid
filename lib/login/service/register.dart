import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:kitob_ol/login/page/verification_code.dart';

class RegisterApiEmail {
  final String registerUrlEmail =
      "https://auth.axadjonovsardorbek.uz/auth/sms/register/email";
  final String loginUrlEmail =
      "https://auth.axadjonovsardorbek.uz/auth/sms/login/email";

  Future<void> loginUserEmail(String email, BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse(registerUrlEmail),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _navigateToVerification(context, email, true);
        _showSnackBar(context, "Kod $email ga yuborildi (Register)");
      } else if (response.statusCode == 400) {
        await _loginUserEmail(email, context);
      } else {
        _showSnackBar(context, "Xatolik yuz berdi: ${response.statusCode}");
      }
    } catch (e) {
      _showSnackBar(context, "Xatolik: $e");
    }
  }

  Future<void> _loginUserEmail(String email, BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse(loginUrlEmail),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _navigateToVerification(context, email, false);
        // ignore: use_build_context_synchronously
        _showSnackBar(context, "Kod $email ga yuborildi (Login)");
      } else {
        _showSnackBar(context, "Login xatosi: ${response.statusCode}");
      }
    } catch (e) {
      _showSnackBar(context, "Login xatosi: $e");
    }
  }

  void _navigateToVerification(
      BuildContext context, String email, bool isRegister) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VerificationCode(
          isEmail: true,
          isRegister: isRegister,
          email: email,
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
