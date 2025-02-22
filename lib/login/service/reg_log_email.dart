import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kitob_ol/login/page/verification_code.dart';

class RegisterApi {
  String registerUrlEmail =
      "https://auth.axadjonovsardorbek.uz/auth/sms/register/email";
  String loginUrlEmail =
      "https://auth.axadjonovsardorbek.uz/auth/sms/login/email";

  Future<Map<String, dynamic>> loginUserEmail(
    String email,
    BuildContext context,
  ) async {
    try {
      Map<String, String> body = {'email': email};
      final response = await http.post(
        Uri.parse(registerUrlEmail),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => VerificationCode(
                    isEmail: true,
                    email: email,
                  )),
          (route) => false, // Orqadagi barcha sahifalarni o‘chirish
        );
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("$email manzilingizga kod yuborildi")));
      } else if (response.statusCode == 400) {
        try {
          Map<String, String> body = {
            'email': email,
          };

          final response = await http.post(
            Uri.parse(loginUrlEmail),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(body),
          );

          if (response.statusCode == 200 || response.statusCode == 201) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => VerificationCode(
                        isEmail: true,
                        email: email,
                      )),
              (route) => false, // Orqadagi barcha sahifalarni o‘chirish
            );
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("$email manzilingizga kod yuborildi")));
          } else {}
        } catch (e) {
          print(e);
        }
      } else {}
    } catch (e) {
      print(e);
    }
    return {};
  }
}
