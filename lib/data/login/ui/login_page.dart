import 'package:flutter/material.dart';
import '../server/login_service.dart';
import '../../token_service.dart';
import 'home_page.dart';

class LoginPageTest extends StatefulWidget {
  final String? number;
  final String? email;
  const LoginPageTest({super.key, this.email, this.number});

  @override
  _LoginPageTestState createState() => _LoginPageTestState();
}

class _LoginPageTestState extends State<LoginPageTest> {
  final TextEditingController _codeController = TextEditingController();

  final LoginService _loginService = LoginService();
  final TokenService _tokenService = TokenService();

  Future<void> _login() async {
    final auth = widget.number ?? widget.email;
    final code = _codeController.text;

    final tokens = await _loginService.login(
        widget.number != null ? true : false, auth ?? "", code);

    if (tokens != null) {
      await _tokenService.saveTokens(
        tokens['accessToken']!,
        tokens['refreshToken']!,
        tokens['role']!,
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePageTest()),
        (route) => false, // Orqadagi barcha sahifalarni o‘chirish
      );
    } else {
      print("Login muvaffaqiyatsiz");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Page")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _codeController,
              decoration: InputDecoration(labelText: "Confirmation Code"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
