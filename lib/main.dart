import 'package:kitob_ol/provider.dart';
import 'package:kitob_ol/provider_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/home/ui/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final AuthProvider authProvider = AuthProvider();
  await authProvider.loadToken(); // Tokenni yuklash
  print("main token:${authProvider.token}");

  runApp(
    MultiProvider(
      //ProfileProvider
      providers: [
        ChangeNotifierProvider(create: (_) => FilterProvider()),
        ChangeNotifierProvider(create: (_) {
          AuthProvider authProvider = AuthProvider();
          authProvider.loadToken(); // Tokenni yuklash
          return authProvider;
        }),
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
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
