import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kitob_ol/login/page/verification_code.dart';

class RegisterApiPhone {
  String registerUrlEmail =
      "https://auth.axadjonovsardorbek.uz/auth/sms/register/phone";
  String loginUrlEmail =
      "https://auth.axadjonovsardorbek.uz/auth/sms/login/phone";
  Future<Map<String, dynamic>> loginUserPhone(
    String phone,
    BuildContext context,
  ) async {
    print("Response");
    //TODO                    REGISTER
    try {
      Map<String, String> body = {
        'phone': phone,
      };

      final response = await http.post(
        Uri.parse(registerUrlEmail),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("200 register");

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => VerificationCode(
                    isEmail: true,
                    isRegister: true,
                    email: phone,
                  )),
        );
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Kod ${phone}ga yuborildi Register")));

//                         TODO Login
//
      } else if (response.statusCode == 400) {
        print("${response.statusCode} login");

        try {
          Map<String, String> body = {
            'email': phone,
          };
          final response = await http.post(
            Uri.parse(loginUrlEmail),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(body),
          );
          if (response.statusCode == 200 || response.statusCode == 201) {
            print("object");
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VerificationCode(
                        isEmail: true,
                        isRegister: false,
                        email: phone,
                      )),
            );
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Kod ${phone}ga yuborildi Login")));
          } else if (response.statusCode == 500) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Kod xato iltimos kodni qaytadan tekshiring")));
          } else if (response.statusCode == 401) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    "Texnik ishlar olib borilmoqda tez orada bartaraf editladi")));
          } else {}
        } catch (e) {
          print(e);
        }
      }
    } catch (e) {
      print(e);
    }

    return {};
  }
}
