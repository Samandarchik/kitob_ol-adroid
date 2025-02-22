import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kitob_ol/main.dart';

class ProfileService {
  String? token = AuthService.token; // Tokenni AuthService'dan olish
  final String url = "https://auth.axadjonovsardorbek.uz/auth/profile";
  final String refreshUrl =
      "https://auth.axadjonovsardorbek.uz/auth/user/refresh/token";

  final String updateUrl =
      "https://auth.axadjonovsardorbek.uz/auth/user/update";

  Future<UserDataModel> fetchProfile() async {
    // 1. Foydalanuvchi profilini olish uchun so‘rov
    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": token != null ? "Bearer $token" : "",
        "Content-Type": "application/json",
      },
    );

    // 2. Agar so‘rov muvaffaqiyatli bo‘lsa (200)
    if (response.statusCode == 200) {
      print("Profile data fetched successfully");
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return UserDataModel.fromJson(jsonData);
    }

    // 3. Agar token muddati tugagan bo‘lsa (401), yangilashga harakat qilish
    if (response.statusCode == 401) {
      print("Token expired. Refreshing...");
      final refreshResponse = await http.post(Uri.parse(refreshUrl));

      if (refreshResponse.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(refreshResponse.body);
        String newToken = jsonData['access_token'];

        // Yangi tokenni saqlash
        await AuthService.saveToken(newToken, AuthService.refreshToken ?? '');
        token = newToken; // Yangi tokenni o‘zgaruvchiga yuklash

        // 4. Yangi token bilan qayta so‘rov jo‘natish
        final retryResponse = await http.get(
          Uri.parse(url),
          headers: {
            "Authorization": token != null ? "Bearer $token" : "",
            "Content-Type": "application/json",
          },
        );

        if (retryResponse.statusCode == 200) {
          print("Profile data fetched successfully after refresh");
          final Map<String, dynamic> retryJsonData =
              json.decode(retryResponse.body);
          return UserDataModel.fromJson(retryJsonData);
        } else {
          throw Exception(
              'Failed to load profile data after refresh: ${retryResponse.statusCode}');
        }
      } else {
        throw Exception('Token refresh failed: ${refreshResponse.statusCode}');
      }
    }

    // 5. Agar boshqa xato bo‘lsa
    throw Exception('Failed to load profile data: ${response.statusCode}');
  }

  Future<void> updateProfile(
      UserDataModel userUpdate, BuildContext context) async {
    final response = await http.put(
      Uri.parse(updateUrl),
      headers: {
        "Authorization": token != null ? "Bearer $token" : "",
        "Content-Type": "application/json",
      },

      body: jsonEncode(userUpdate.toJson()), // JSON formatda serverga yuborish
    );

    if (response.statusCode == 200) {
      print("Profile data updated successfully");
      Navigator.pop(
        context,
      );
      Navigator.pop(
        context,
      );
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Malumotlar muvaffaqiyatli yangilandi"),
      ));
    } else if (response.statusCode == 409) {
      print(response.body);
    } else {
      throw Exception('Failed to update profile data: ${response.statusCode}');
    }
  }
}

class UserDataModel {
  final String name;
  final String lastName;
  final String birthday;
  final String number;
  final String email;
  final String? imageUrl;
  final String role;

  UserDataModel(
    this.name,
    this.lastName,
    this.birthday,
    this.number,
    this.email,
    this.imageUrl,
    this.role,
  );

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      json["first_name"] ?? "null",
      json["last_name"] ?? "null",
      json["date_of_birth"] ?? "null",
      json["phone_number"] ?? "null",
      json["email"] ?? "null",
      json["image_url"] ?? "null",
      json["role"] ?? "null",
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "first_name": name,
      "last_name": lastName,
      "date_of_birth": birthday,
      "phone_number": number,
      "email": email,
      "image_url":
          "https://www.hubspot.com/hs-fs/hubfs/parts-url_1.webp?width=595&name=parts-url_1.webp",
    };
  }
}
