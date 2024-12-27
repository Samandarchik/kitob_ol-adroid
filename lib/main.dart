import 'package:flutter/material.dart';
import 'package:kitob_ol/color.dart'; // Sizning color.dart faylingizni import qilyapman
import 'package:kitob_ol/login/page/register.dart'; // Register sahifasi
import 'package:kitob_ol/home/page/home.dart';
import 'package:kitob_ol/login/service/verfication_code.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        datePickerTheme: DatePickerThemeData(
            rangePickerBackgroundColor: kred,
            rangeSelectionBackgroundColor: kred,
            backgroundColor: kWhite),
        appBarTheme: const AppBarTheme(color: kWhite, surfaceTintColor: kWhite),
        scaffoldBackgroundColor: kWhite,
      ),
      debugShowCheckedModeBanner: false,
      home:
          const HomePage(), // Tokenni tekshirib, kerakli sahifaga yo'naltiramiz
    );
  }
}

class AuthRedirectPage extends StatelessWidget {
  const AuthRedirectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: VerificationPost().getToken(), //
      builder: (context, snapshot) {
        // Agar token o'qilayotgan bo'lsa
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Agar token mavjud bo'lsa, HomePage ga o'tkazamiz
        if (snapshot.hasData && snapshot.data != null) {
          return const HomePage(); // Agar foydalanuvchi allaqachon login bo'lsa
        } else {
          return const Register(); // Agar foydalanuvchi login bo'lmagan bo'lsa, Register sahifasini ko'rsatamiz
        }
      },
    );
  }
}
