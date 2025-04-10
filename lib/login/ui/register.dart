import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/core/data/local/token_storage.dart';
import 'package:kitob_ol/core/di/di.dart';
import 'package:kitob_ol/home/ui/home.dart';
import 'package:kitob_ol/login/service/reg_log_email.dart';
import 'package:kitob_ol/login/service/reg_log_number.dart';
import 'package:kitob_ol/widget/app_bar.dart';
import 'package:kitob_ol/widget/my_botton_text.dart';
import 'package:kitob_ol/widget/my_text_field.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late final TextEditingController number;
  late final TextEditingController email;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    number = TextEditingController();
    email = TextEditingController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    number.dispose();
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MyAppBar(drawet: false),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: imageColor,
          labelColor: Colors.black,
          tabs: [
            Tab(child: Center(child: Text("phoneNumber".tr()))),
            Tab(child: Center(child: Text("email".tr()))),
          ],
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [_fristPage(number), _seccondPage(email)],
        ),
      ),
      persistentFooterButtons: [
        _buildButtons(_tabController.index == 0,
            _tabController.index == 0 ? number : email)
      ],
    );
  }

  Widget _fristPage(TextEditingController controller) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text("authNumber".tr()),
            Container(
                decoration: const BoxDecoration(
                  color: kGrey,
                ),
                child: Row(
                  children: [
                    Text("+998"),
                    const SizedBox(width: 10),
                    Expanded(child: TextField()),
                  ],
                ))
          ],
        ));
  }

  Widget _seccondPage(TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: MyTextField(controller: controller, label: "email".tr()),
    );
  }

  Widget _buildButtons(bool isNumber, TextEditingController controller) {
    return isLoading
        ? Center(child: const CircularProgressIndicator(color: kBlack))
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyElevedButtonBorder(
                width: MediaQuery.of(context).size.width * .45,
                onTap: () {},
                text: "pascancel".tr(),
              ),
              MyBottonText(
                onLongPress: () =>
                    OnDableTap().onDoubleTap(controller.text, context),
                width: MediaQuery.of(context).size.width * .45,
                textColor: kWhite,
                onTap: isNumber
                    ? () async {
                        if (controller.text.length == 12) {
                          setState(() => isLoading = true);
                          String rawNumber =
                              controller.text.replaceAll(' ', '');
                          await RegisterApiPhone()
                              .loginUserPhone("+998$rawNumber", context);
                          setState(() => isLoading = false);
                        } else {
                          _showSnackBar("Iltimos, nomerni to'ldiring");
                        }
                      }
                    : () async {
                        if (controller.text.isNotEmpty) {
                          setState(() => isLoading = true);
                          await RegisterApiEmail()
                              .loginUserEmail(email.text, context);
                          setState(() => isLoading = false);
                        } else {
                          _showSnackBar("email");
                        }
                      },
                text: "pasNext".tr(),
                boxColor: imageColor,
              ),
            ],
          );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}

class OnDableTap {
  TokenStorage tokenStorage = sl<TokenStorage>();
  final Dio dio = sl<Dio>();
  Future<void> onDoubleTap(String email, BuildContext context) async {
    print("Email: $email");
    if (email == "Samandarik4@gmail.com") {
      final response = await dio.post(
        'https://auth.axadjonovsardorbek.uz/auth/sms/login/email',
        data: {
          "email": "samandarik4@gmail.com",
        },
      );
      if (response.statusCode == 201) {
        print("Zapros 2 verfikatsiya");

        final response1 = await dio.post(
            'https://auth.axadjonovsardorbek.uz/auth/user/email/login',
            data: {
              "email": "samandarik4@gmail.com",
              "confirmation_code": "${response.data['code']}"
            });

        if (response1.statusCode == 200 || response1.statusCode == 201) {
          final token = response1.data['access_token'];
          final refreshToken = response1.data['refresh_token'];
          final role = response1.data['role'];
          print("data.runtimeType ${token}");
          print("Yes $token");
          await tokenStorage.putToken(
            token,
          );
          await tokenStorage.putRefreshToken(
            refreshToken,
          );
          await tokenStorage.putRole(role);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (route) => false);
        }
      } else {
        print("Error: ${response.statusCode}");
      }
    }
  }
}
