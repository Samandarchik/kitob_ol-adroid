import 'package:dio/dio.dart';
import 'package:kitob_ol/core/data/local/token_storage.dart';
import 'package:kitob_ol/core/di/di.dart';
import 'package:kitob_ol/home/model/user_info_model.dart';

class ProfileService {
  final Dio _dio = sl<Dio>();

  // Profilni olish metodi
  Future<UserDataModel> fetchProfile() async {
    try {
      final token = sl<TokenStorage>().getToken();
      final response = await _dio.get(
        'https://auth.axadjonovsardorbek.uz/auth/profile',
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );

      print("Status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        return UserDataModel.fromJson(response.data);
      }

      throw Exception('⚠️ Xatolik: Status code ${response.statusCode}');
    } catch (e) {
      print("❌ Xatolik: $e");
      throw Exception("Tizimda xatolik: $e");
    }
  }
}
