import 'package:kitob_ol/provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:kitob_ol/book_create.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/home/page/home.dart';
import 'package:kitob_ol/login/page/register.dart';
import 'package:kitob_ol/login/service/token.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService.loadToken(); // Tokenni yuklash
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FilterProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: kWhite,
          appBarTheme:
              AppBarTheme(backgroundColor: kWhite, surfaceTintColor: kWhite)),
      home: AuthService.token != null
          ? HomePage()
          : Register(), // Token borligini tekshirish
      debugShowCheckedModeBanner: false,
    );
  }
}

class AuthService {
  static String? token;
  static String? refreshToken;

  static Future<void> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('access_token');
    refreshToken = prefs.getString('refresh_token');
    // print("Loaded Token: $token");
    // print("Loaded Refresh Token: $refreshToken"); TODO token
  }

  static Future<void> saveToken(String newToken, String newRefreshToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', newToken);
    await prefs.setString('refresh_token', newRefreshToken);
    token = newToken;
    refreshToken = newRefreshToken;
  }

  static Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
    token = null;
    refreshToken = null;
  }
}
