import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:kitob_ol/login/page/verification_code.dart';

class RegisterApiProvider extends ChangeNotifier {
  bool _isLoding = false;
  bool get isLoding => _isLoding;
  void lodingTrue() {
    _isLoding = true;
  }

  String registerUrlEmail =
      "https://auth.axadjonovsardorbek.uz/auth/sms/register/email";
  String loginUrlEmail =
      "https://auth.axadjonovsardorbek.uz/auth/sms/login/email";
  Future<Map<String, dynamic>> loginUserEmail(
    String email,
    BuildContext context,
  ) async {
    //TODO                    REGISTER
    try {
      Map<String, String> body = {
        'email': email,
      };

      final response = await http.post(
        Uri.parse(registerUrlEmail),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => VerificationCode(
                    isEmail: true,
                    isRegister: true,
                    email: email,
                  )),
        );
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Kod ${email}ga yuborildi Register")));

//                         TODO Login
//
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
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VerificationCode(
                        isEmail: true,
                        isRegister: false,
                        email: email,
                      )),
            );
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Kod ${email}ga yuborildi Login")));
          }
        } catch (e) {}
      }
    } catch (e) {}

    return {};
  }
}
