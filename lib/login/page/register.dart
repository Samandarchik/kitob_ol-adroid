import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/login/page/verification_code.dart';
import 'package:kitob_ol/login/service/reg_log_number.dart';
import 'package:kitob_ol/login/service/register.dart';
import 'package:kitob_ol/login/service/register_post.dart';
import 'package:kitob_ol/text_style.dart';
import 'package:kitob_ol/widget/app_bar.dart';
import 'package:kitob_ol/widget/my_botton_text.dart';
import 'package:kitob_ol/widget/my_text_field.dart';
import 'package:kitob_ol/widget/text_class.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final RegisterPost post = RegisterPost();
  final TextEditingController number = TextEditingController();
  final TextEditingController email = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const MyAppBar(
            drawet: false,
          ),
          bottom: const TabBar(
            indicatorColor: imageColor,
            labelColor: Colors.black,
            tabs: [
              Tab(child: Center(child: Text("Telefon raqam"))),
              Tab(child: Center(child: Text("Email"))),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              _buildTabContent(
                context,
                "Telefon raqamingizni kiriting",
                "99 123 45 67",
                "+998 ",
                "Avtorizatsiya qilish uchun iltimos telefon raqamingini kiriting!",
                true,
                TextInputType.number,
                number,
                (value) {
                  setState(() {
                    number.text = formatPhoneNumber(value);
                    number.selection =
                        TextSelection.collapsed(offset: number.text.length);
                  });
                },
              ),
              _buildTabContent(
                context,
                "Email manzilingizni kiriting",
                "example@gmail.com",
                "",
                "Avtorizatsiya qilish uchun iltimos email manzilingizni kiriting!",
                false,
                TextInputType.emailAddress,
                email,
                (value) {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent(
    BuildContext context,
    String h1,
    String text,
    String label,
    String p,
    bool isNumber,
    TextInputType type,
    TextEditingController controller,
    void Function(String)? onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          MyTextFieldFilled(
            onChanged: onChanged,
            text: text,
            maxLens: true,
            maxLines: isNumber ? 12 : null,
            border: false,
            next: TextInputAction.done,
            hint: label,
            controller: controller,
            label: h1,
            textInputType: type,
          ),
          const SizedBox(height: 14),
          Text(p, style: kTSFS16),
          const Spacer(),
          _buildButtons(isNumber, controller),
        ],
      ),
    );
  }

  Widget _buildButtons(bool isNumber, TextEditingController controller) {
    return isLoading
        ? const CircularProgressIndicator(
            color: kBlack,
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyElevedButtonBorder(
                width: MediaQuery.of(context).size.width * .45,
                onTap: () {},
                text: "Bekor qilish",
              ),
              MyBottonText(
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
                          _showSnackBar("Email manzilingizni kiriting");
                        }
                      },
                text: "Keyingisi",
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
