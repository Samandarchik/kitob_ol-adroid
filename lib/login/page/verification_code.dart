import 'package:flutter/material.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/text_style.dart';
import 'package:kitob_ol/widget/my_botton_text.dart';
import 'package:kitob_ol/widget/text_class.dart';
import 'package:pinput/pinput.dart';

class VerificationCode extends StatefulWidget {
  final bool isEmail;
  final String email;
  final String number;
  const VerificationCode(
      {super.key, this.email = "", this.number = "", required this.isEmail});

  @override
  _VerificationCodeState createState() => _VerificationCodeState();
}

class _VerificationCodeState extends State<VerificationCode> {
  void verificationEmail() {
    // verificationPost.handleEmailLoginOrRegister(
    //     widget.email, textcode.text, context, true);
    print(ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${widget.email}:${textcode.text}"))));
  }

  void verificationPhone() {
    // verificationPost.handleEmailLoginOrRegister(
    //     widget.number, textcode.text, context, false);
    print(
      "${widget.number}:${textcode.text}",
    );
  }

  TextEditingController textcode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextClass textClass = TextClass();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verification Code"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(
                widget.isEmail
                    ? "Bu ${widget.email} sizga tegishli bo'lmasa agar bekor qilish tugmasini bosing\n"
                    : "Siz kiritgan telefon raqamiga +998 ${textClass.formatPhoneNumber(widget.number)} kod yuborildi. Iltimos kodni kiriting!\n",
                style: kTSFWB18,
              ),
              const SizedBox(height: 20),
              code(textcode),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyElevedButtonBorder(
                    width: size.width * .42,
                    onTap: () {
                      // tokenStorage.removeToken;
                    },
                    text: 'Orqaga',
                  ),
                  MyBottonText(
                    width: size.width * .42,
                    text: "Keyingisi",
                    boxColor: imageColor,
                    textColor: kWhite,
                    onTap: () {
                      verificationPhone();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Center code(TextEditingController textcode) {
    return Center(
      child: Pinput(
        length: 6,
        controller: textcode,
      ),
    );
  }
}
