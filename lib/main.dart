import 'package:easy_localization/easy_localization.dart';
import 'package:kitob_ol/core/di/di.dart';
import 'package:kitob_ol/home/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:kitob_ol/color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized(); //
  await setupInit();
  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale('en', 'US'),
        Locale('uz', 'UZ'),
        Locale('ru', 'RU')
      ],
      startLocale: Locale("en", "US"),
      path: 'assets/translations',
      fallbackLocale: Locale('en', 'US'),
      child: MyApp(),
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
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
    );
  }
}
