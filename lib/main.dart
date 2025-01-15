import 'package:flutter/material.dart';
import 'package:kitob_ol/color.dart'; // Sizning color.dart faylingizni import qilyapman
import 'package:kitob_ol/home/page/home.dart';
import 'package:kitob_ol/login/page/register.dart';
import 'package:kitob_ol/login/page/verification_code.dart';
import 'package:kitob_ol/profile/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          dropdownMenuTheme: DropdownMenuThemeData(
              menuStyle: MenuStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(kWhite))),
          datePickerTheme: DatePickerThemeData(
              rangePickerBackgroundColor: kred,
              rangeSelectionBackgroundColor: kred,
              backgroundColor: kWhite),
          appBarTheme:
              const AppBarTheme(color: kWhite, surfaceTintColor: kWhite),
          scaffoldBackgroundColor: kWhite,
        ),
        debugShowCheckedModeBanner: false,
        home: HomePage());
  }
}
