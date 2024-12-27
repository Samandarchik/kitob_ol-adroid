import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  // Tokenni saqlash
  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'user_token', token); // 'user_token' kaliti orqali tokenni saqlaymiz
  }

  // Tokenni olish
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs
        .getString('user_token'); // 'user_token' kaliti orqali tokenni olamiz
  }

  // Tokenni o'chirish
  Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_token'); // 'user_token'ni o'chiramiz
  }
}
