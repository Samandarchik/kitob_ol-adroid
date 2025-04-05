import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();

  factory AuthService() => _instance;

  AuthService._internal();

  String? _token;
  String? _refreshToken;
  bool get isRegister => _token != null;
  Future<void> loadTokens() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _token = prefs.getString('access_token');
      _refreshToken = prefs.getString('refresh_token');
    } catch (e) {
      print('Token yuklashda xatolik: $e');
    }
  }

  Future<void> saveTokens(
      String newToken, String newRefreshToken, String role) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', newToken);
      await prefs.setString('refresh_token', newRefreshToken);
      await prefs.setString("role", role);
      _token = newToken;
      _refreshToken = newRefreshToken;
    } catch (e) {
      print('Token saqlashda xatolik: $e');
    }
  }

  Future<void> clearTokens() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('access_token');
      await prefs.remove('refresh_token');
      _token = null;
      _refreshToken = null;
    } catch (e) {
      print('Token o‘chirishda xatolik: $e');
    }
  }

  Future<void> refreshAccessToken() async {
    try {
      if (_refreshToken == null) {
        throw Exception('Refresh token mavjud emas!');
      }
      String newToken = 'newAccessTokenFromApi';
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', newToken);
      _token = newToken;
    } catch (e) {
      print('Token yangilashda xatolik: $e');
    }
  }

  Future<String?> getToken() async {
    if (_token == null) await loadTokens();
    return _token;
  }

  Future<String?> getRefreshToken() async {
    if (_refreshToken == null) await loadTokens();
    return _refreshToken;
  }

  Future<String?> getValidToken() async {
    String? token = await getToken();
    if (token == null) {
      await refreshAccessToken();
      token = _token;
    }
    return token;
  }
}
