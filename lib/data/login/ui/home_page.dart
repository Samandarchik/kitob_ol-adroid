import 'package:flutter/material.dart';
import 'package:kitob_ol/color.dart';
import '../../token_service.dart';

class HomePageTest extends StatelessWidget {
  final TokenService _tokenService = TokenService();

  Future<Map<String, String?>> _getTokens() async {
    return await _tokenService.getTokens();
  }

  Future<void> _logout(BuildContext context) async {
    await _tokenService.removeTokens();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: FutureBuilder<Map<String, String?>>(
        future: _getTokens(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              color: kBlack,
            ));
          }

          if (snapshot.hasData) {
            final tokens = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Access Token: ${tokens['accessToken']}"),
                  SizedBox(height: 10),
                  Text("Refresh Token: ${tokens['refreshToken']}"),
                  SizedBox(height: 10),
                  Text("Role: ${tokens['role']}"),
                ],
              ),
            );
          }

          return Center(child: Text("Tokenlar mavjud emas."));
        },
      ),
    );
  }
}
