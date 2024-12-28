import 'package:flutter/material.dart';
import 'package:kitob_ol/color.dart'; // Sizning color.dart faylingizni import qilyapman
import 'package:kitob_ol/home/page/ui.dart';
import 'package:kitob_ol/login/page/register.dart';
import 'package:kitob_ol/vacancies/ui/vacancies_ui.dart';
import 'package:kitob_ol/vacancies/widgets/vacancies_card.dart'; // Register sahifasi

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
      home: VacancyListScreen(),
    );
  }
}

class AuthRedirectPage extends StatelessWidget {
  const AuthRedirectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Register();
  }
}
