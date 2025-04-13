import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kitob_ol/core/data/local/token_storage.dart';
import 'package:kitob_ol/core/di/di.dart';
import 'package:kitob_ol/home/ui/home.dart';

class OnDableTap {
  TokenStorage tokenStorage = sl<TokenStorage>();
  final Dio dio = sl<Dio>();
  Future<void> onDoubleTap(String email, BuildContext context) async {
    print("Email: $email");
    if (email == "Samandarik4@gmail.com") {
      final response = await dio.post(
        'https://auth.axadjonovsardorbek.uz/auth/sms/login/email',
        data: {
          "email": "samandarik4@gmail.com",
        },
      );
      if (response.statusCode == 201) {
        print("Zapros 2 verfikatsiya");

        final response1 = await dio.post(
            'https://auth.axadjonovsardorbek.uz/auth/user/email/login',
            data: {
              "email": "samandarik4@gmail.com",
              "confirmation_code": "${response.data['code']}"
            });

        if (response1.statusCode == 200 || response1.statusCode == 201) {
          final token = response1.data['access_token'];
          final refreshToken = response1.data['refresh_token'];
          final role = response1.data['role'];
          print("data.runtimeType ${token}");
          print("Yes $token");
          await tokenStorage.putToken(
            token,
          );
          await tokenStorage.putRefreshToken(
            refreshToken,
          );
          await tokenStorage.putRole(role);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (route) => false);
        }
      } else {
        print("Error: ${response.statusCode}");
      }
    }
  }
}
