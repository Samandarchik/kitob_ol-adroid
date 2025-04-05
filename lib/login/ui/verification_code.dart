import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kitob_ol/login/service/ver_code.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/login/service/token.dart';
import 'package:kitob_ol/text_style.dart';
import 'package:kitob_ol/widget/my_botton_text.dart';
import 'package:kitob_ol/widget/text_class.dart';
import 'package:pinput/pinput.dart';

class VerificationCode extends StatefulWidget {
  final bool isEmail;
  final String email;
  final String number;
  final bool? isRegister;

  const VerificationCode({
    super.key,
    this.email = "",
    this.number = "",
    required this.isEmail,
    this.isRegister,
  });

  @override
  _VerificationCodeState createState() => _VerificationCodeState();
}

class _VerificationCodeState extends State<VerificationCode> {
  @override
  void dispose() {
    _timer?.cancel(); // Birinchi timer
    timer.cancel(); // Ikkinchi timer
    super.dispose();
  }

  DateTime? sentTime; // Kod yuborilgan vaqt
  Duration countdownDuration = const Duration(minutes: 3); // 3 daqiqa
  late Timer timer;
  int remainingSeconds = 0;
  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          remainingSeconds = countdownDuration.inSeconds -
              DateTime.now().difference(sentTime!).inSeconds;

          if (remainingSeconds <= 0) {
            timer.cancel();
            remainingSeconds = 0;
            Navigator.pop(context);
          }
        });
      }
    });
  }

  TokenStorage tokenStorage = TokenStorage();
  TextEditingController textcode = TextEditingController();
  Timer? _timer;
  int _remainingTime = 0;
  static const int smsTimeout = 180; // 3 daqiqa (180 sekund)

  @override
  void initState() {
    super.initState();
    _loadRemainingTime();
    sentTime = DateTime.now(); // Joriy vaqtni saqlash
    remainingSeconds = countdownDuration.inSeconds; // 3 daqiqa belgilash
    startTimer(); // Timer boshlash
  }

  // // SMS yuborilgan vaqtni saqlash
  // Future<void> _saveSmsTimestamp() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setInt('sms_sent_time', DateTime.now().millisecondsSinceEpoch);
  // }

  // Saqlangan vaqtni yuklash va hisoblash
  Future<void> _loadRemainingTime() async {
    final prefs = await SharedPreferences.getInstance();
    int? sentTime = prefs.getInt('sms_sent_time');

    if (sentTime != null) {
      int elapsed = (DateTime.now().millisecondsSinceEpoch - sentTime) ~/ 1000;
      int remaining = smsTimeout - elapsed;
      if (remaining > 0) {
        setState(() {
          _remainingTime = remaining;
        });
        _startTimer();
      } else {
        setState(() {
          _remainingTime = 0;
        });
      }
    }
  }

  // Timer ishga tushiradi
  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  // Kod yuborilganida vaqtni saqlash
  // void _sendSms() {
  //   setState(() {
  //     _remainingTime = smsTimeout;
  //   });
  //   _saveSmsTimestamp();
  //   _startTimer();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextClass textClass = TextClass();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "verificationCode".tr(),
          style: kTSFWB18,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Column(
                children: [
                  Text(
                    widget.isEmail
                        ? tr("poseEmail", args: [widget.email])
                        : "Siz kiritgan telefon raqamiga +998 ${textClass.formatPhoneNumber(widget.number)} kod yuborildi. Iltimos kodni kiriting!\n",
                    style: kTSFWB18,
                  ),
                  SizedBox(height: 10),
                  if (sentTime != null)
                    Text(
                      "${"time".tr()} ${remainingSeconds ~/ 60}:${(remainingSeconds % 60).toString().padLeft(2, '0')}",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                ],
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
                      Navigator.pop(context);
                    },
                    text: 'exit'.tr(),
                  ),
                  MyBottonText(
                    width: size.width * .42,
                    text: "pasNext".tr(),
                    boxColor: imageColor,
                    textColor: kWhite,
                    onTap: () {
                      if (textcode.text.length == 6) {
                        VerificationCodeApi().verificationCode(
                            textcode.text, widget.email, context, false);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Sms orqali kelgan kodni kiriting")));
                      }
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
