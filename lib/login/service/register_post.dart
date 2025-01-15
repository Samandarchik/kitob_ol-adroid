import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kitob_ol/login/page/verification_code.dart';

class RegisterPost {
  String registerUrlNumber =
      "https://auth.axadjonovsardorbek.uz/auth/sms/register/phone";
  String registerUrlEmail =
      "https://auth.axadjonovsardorbek.uz/auth/sms/register/email";
  String loginUrlPhone =
      "https://auth.axadjonovsardorbek.uz/auth/sms/login/phone";
  String loginUrlEmail =
      "https://auth.axadjonovsardorbek.uz/auth/sms/login/email";

  // Telefon raqam bilan ro'yxatdan o'tish
  Future<Map<String, dynamic>> registerUserNumber(
    String phone,
    BuildContext context,
  ) async {
    try {
      if (phone.isEmpty || phone.length != 9) {
        return {
          'success': false,
          'message': 'Telefon raqami noto\'g\'ri formatda.'
        };
      }

      Map<String, String> body = {
        'phone': "+998$phone", // Telefon raqami
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
          return {'success': true, 'message': 'Sms yuborildi'};
        }
      } else if (response.statusCode == 400) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData['message'] == 'such phone exists') {
          await loginUserNumber(phone, context);
        } else {
          showErrorMessage(context, response.body);
        }
      } else {
        showErrorMessage(context, response.body);
      }

      return {
        'success': false,
        'message': 'Registratsiya xatolik: ${response.statusCode}'
      };
    } catch (e) {
      showErrorMessage(context, 'Xato: $e');
      return {'success': false, 'message': 'Xato: $e'};
    }
  }

  // Login (Telefon raqami bilan)
  Future<void> loginUserNumber(
    String phone,
    BuildContext context,
  ) async {
    try {
      Map<String, String> body = {
        'phone': "+998$phone", // Telefon raqami
      };

      final response = await http.post(
        Uri.parse(loginUrlPhone),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => VerificationCode(
                    number: phone,
                    isEmail: false,
                  )),
        );
      } else {
        showErrorMessage(context, response.body);
      }
    } catch (e) {
      showErrorMessage(context, 'Login xatosi: $e');
    }
  }

  // Elektron pochta bilan ro'yxatdan o'tish
  Future<Map<String, dynamic>> registerUserEmail(
    String email,
    BuildContext context,
  ) async {
    try {
      if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
          .hasMatch(email)) {
        return {'success': false, 'message': 'Email noto\'g\'ri formatda.'};
      }

      Map<String, String> body = {
        'email': email, // Email manzili
      };

      final response = await http.post(
        Uri.parse(registerUrlEmail),
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
                isEmail: true,
                email: email,
              ),
            ),
          );
          return {'success': true, 'message': 'Sms yuborildi'};
        }
      } else if (response.statusCode == 400) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData['message'] == 'such email exists') {
          await loginUserEmail(email, context);
        } else {
          showErrorMessage(context, response.body);
        }
      } else {
        showErrorMessage(context, response.body);
      }

      return {
        'success': false,
        'message': 'Registratsiya xatolik: ${response.statusCode}'
      };
    } catch (e) {
      showErrorMessage(context, 'Xato: $e');
      return {'success': false, 'message': 'Xato: $e'};
    }
  }

  // Login (Email bilan)
  Future<void> loginUserEmail(
    String email,
    BuildContext context,
  ) async {
    try {
      Map<String, String> body = {
        'email': email, // Email manzili
      };

      final response = await http.post(
        Uri.parse(loginUrlEmail),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  VerificationCode(email: email, isEmail: true)),
        );
      } else {
        showErrorMessage(context, response.body);
      }
    } catch (e) {
      showErrorMessage(context, 'Login xatosi: $e');
    }
  }

  // Xato xabarlarini ko'rsatish
  void showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // Foydalanuvchining mavjudligini tekshirish
  Future<void> checkUserExistenceAndLogin(
      String phoneOrEmail, bool isEmail, BuildContext context) async {
    try {
      String url = isEmail
          ? "https://auth.axadjonovsardorbek.uz/auth/user/check/email"
          : "https://auth.axadjonovsardorbek.uz/auth/user/check/phone";
      Map<String, String> body =
          isEmail ? {'email': phoneOrEmail} : {'phone': "+998$phoneOrEmail"};

      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        // Agar foydalanuvchi ro'yxatdan o'tgan bo'lsa, login qilish
        if (isEmail) {
          await loginUserEmail(phoneOrEmail, context);
        } else {
          await loginUserNumber(phoneOrEmail, context);
        }
      } else if (response.statusCode == 404) {
        // Agar foydalanuvchi ro'yxatdan o'tmagan bo'lsa, uni ro'yxatdan o'tkazish
        if (isEmail) {
          await registerUserEmail(phoneOrEmail, context);
        } else {
          await registerUserNumber(phoneOrEmail, context);
        }
      } else {
        showErrorMessage(
            context, "Foydalanuvchi tekshirishda xato: ${response.body}");
      }
    } catch (e) {
      showErrorMessage(context, "Xato: $e");
    }
  }
}
