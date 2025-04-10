import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> refreshToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  const String url =
      'https://auth.axadjonovsardorbek.uz/auth/user/refresh/token';

  final Dio dio = Dio();

  try {
    final response = await dio.post(
      url,
      data: {
        "token":
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InNhbWFuZGFyaWs0QGdtYWlsLmNvbSIsImV4cCI6MTc0NDg5MTI1NSwiaWF0IjoxNzQyMjk5MjU1LCJwaG9uZV9udW1iZXIiOiIrOTk4NzcwNDUxMTE3Iiwicm9sZSI6InVzZXIiLCJ1c2VyX2lkIjoiZThjYzY1NDAtNjYwOS00YzZmLThiOGUtMmYxOGQyMDE2ODdkIn0.H_GkkNE_OjCGghlG3pNEExw0I_qH4nmQAcjyeKJAc_0"
      },
    );
    print(response.statusCode);
    print("rrrrrrrrrrr ${response.data}");
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = response.data;
      prefs.setString('access_token', data['access_token']);
      prefs.setString('refresh_token', data['refresh_token']);
      print("Access token: ${data['access_token']}");
      print("Refresh token: ${data['refresh_token']}");
    } else {
      print("Error: ${response.statusCode}");
    }
  } catch (e) {
    print("Exception: $e");
  }
}
