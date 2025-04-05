import 'package:kitob_ol/home/service/filter_widget_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  // Tokenni saqlash
  Future<void> saveToken(String newToken, String newRefreshToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', newToken);
    await prefs.setString('refresh_token', newRefreshToken);
    await getToken(); // Saqlangan tokenlarni darhol olish
  }

  // Tokenni olish va global o'zgaruvchilarga tenglash
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  Future<String?> getRefreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('refresh_token');
  }

  // Tokenni o‘chirish
  Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
  }

  // Narxni saqlash
  Future<void> savePrice(String min, String max) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("price", [min, max]);
  }

  // Narxni olish
  Future<void> getPrice() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? price = prefs.getStringList("price");
    minPrice = double.parse(price![0]);
    maxPrice = double.parse(price[1]);
  }
}
