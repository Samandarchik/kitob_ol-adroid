import 'base_storage.dart';

final class TokenStorage {
  static const String _token = 'auth_token';
  static const String _refreshToken = 'refresh_token';

  final BaseStorage _baseStorage;

  TokenStorage(this._baseStorage);

  Future<void> putToken(String token) async {
    await _baseStorage.putString(key: _token, value: token);
  }

  Future<void> putRefreshToken(String refreshToken) async {
    await _baseStorage.putString(key: _refreshToken, value: refreshToken);
  }

  String getToken() {
    return _baseStorage.getString(key: _token) ?? '';
  }

  String getRefreshToken() {
    return _baseStorage.getString(key: _refreshToken) ?? '';
  }

  Future<void> removeToken() async {
    await _baseStorage.remove(key: _token);
  }

  Future<void> removeRefreshToken() async {
    await _baseStorage.remove(key: _refreshToken);
  }
}
