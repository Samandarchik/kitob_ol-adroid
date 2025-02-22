import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  double? minPrice;
  double? maxPrice;
  String? token;
  String? refreshToken;

  // Tokenni saqlash
  Future<void> saveToken(String newToken, String newRefreshToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', newToken);
    await prefs.setString('refresh_token', newRefreshToken);
    await getToken(); // Saqlangan tokenlarni darhol olish
  }

  // Tokenni olish va global o'zgaruvchilarga tenglash
  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('access_token');
    refreshToken = prefs.getString('refresh_token');
  }

  // Tokenni o‘chirish
  Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
    token = null;
    refreshToken = null;
  }

  // Narxni saqlash
  Future<void> savePrice(String min, String max) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("price", [min, max]);
    await getPrice();
  }

  // Narxni olish
  Future<void> getPrice() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final getPrice = prefs.getStringList("price");
    minPrice = double.tryParse(getPrice?[0] ?? "0");
    maxPrice = double.tryParse(getPrice?[1] ?? "500000");
  }
}
