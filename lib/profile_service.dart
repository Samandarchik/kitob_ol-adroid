import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kitob_ol/home/model/user_info_model.dart';
import 'package:kitob_ol/provider_auth.dart';

class ProfileService {
  final String url = "https://auth.axadjonovsardorbek.uz/auth/profile";
  final String refreshUrl =
      "https://auth.axadjonovsardorbek.uz/auth/user/refresh/token";
  final String updateUrl =
      "https://auth.axadjonovsardorbek.uz/auth/user/update";

  Future<UserDataModel> fetchProfile(AuthProvider authProvider) async {
    try {
      String? token = authProvider.token;

      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return UserDataModel.fromJson(jsonData);
      }

      if (response.statusCode == 401 || response.statusCode == 403) {
        print("Token expired. Refreshing...");
        final refreshResponse = await http.post(
          Uri.parse(refreshUrl),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          body: jsonEncode({"refresh_token": authProvider.refreshToken}),
        );

        if (refreshResponse.statusCode == 200) {
          final Map<String, dynamic> refreshData =
              json.decode(refreshResponse.body);
          String newToken = refreshData['access_token'];

          // Yangi tokenni saqlash
          await authProvider.saveToken(
              newToken, authProvider.refreshToken ?? '');

          // Qayta so‘rov
          final retryResponse = await http.get(
            Uri.parse(url),
            headers: {
              "Authorization": "Bearer $newToken",
              "Content-Type": "application/json",
            },
          );

          if (retryResponse.statusCode == 200) {
            final Map<String, dynamic> retryJsonData =
                json.decode(retryResponse.body);
            return UserDataModel.fromJson(retryJsonData);
          } else {
            throw Exception(
                'Failed to load profile data after refresh: ${retryResponse.statusCode}');
          }
        } else {
          throw Exception(
              'Token refresh failed: ${refreshResponse.statusCode}');
        }
      }

      throw Exception('Failed to load profile data: ${response.statusCode}');
    } catch (e) {
      print("Error fetching profile data: $e");
      rethrow;
    }
  }

  Future<void> updateProfile(
      UserDataModel userUpdate, BuildContext context, String token) async {
    final response = await http.put(
      Uri.parse(updateUrl),
      headers: {
        "Authorization": token.isNotEmpty ? "Bearer $token" : "",
        "Content-Type": "application/json",
      },
      body: jsonEncode(userUpdate.toJson()),
    );

    if (response.statusCode == 200) {
      print("Profile data updated successfully");
      Navigator.pop(context);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Ma'lumotlar muvaffaqiyatli yangilandi")),
      );
    } else if (response.statusCode == 409) {
      print(response.body);
    } else {
      throw Exception('Failed to update profile data: ${response.statusCode}');
    }
  }
}
