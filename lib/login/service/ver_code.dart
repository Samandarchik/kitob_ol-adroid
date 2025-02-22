import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:kitob_ol/home/page/home.dart';
import 'package:kitob_ol/login/service/token.dart';

class VerificationCodeApi {
  String verLoginCode =
      "https://auth.axadjonovsardorbek.uz/auth/user/email/login";
  String verRegisCode =
      "https://auth.axadjonovsardorbek.uz/auth/user/email/register";
  Future<Map<String, String>> verificationCode(
      String code, String email, BuildContext context, bool isRegister) async {
    try {
      Map<String, String> body = {"confirmation_code": code, "email": email};
      final response = await http.post(
          Uri.parse(
            isRegister ? verRegisCode : verLoginCode,
          ),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body));
      if (response.statusCode == 201 || response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final token = responseData['access_token'];
        final refreshToken = responseData['refresh_token'];
        // refresh_token

        final tokenStorage = TokenStorage();
        await tokenStorage.saveToken(token, refreshToken);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else if (response.statusCode == 500) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Kod xato iltimos kodni qaytadan tekshiring")));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("${response.statusCode}")));
      }
    } catch (e) {}
    return {};
  }
}
