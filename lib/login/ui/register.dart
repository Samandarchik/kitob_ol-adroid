import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/core/app_validation.dart';
import 'package:kitob_ol/core/data/local/token_storage.dart';
import 'package:kitob_ol/core/di/di.dart';
import 'package:kitob_ol/home/ui/home.dart';
import 'package:kitob_ol/login/service/reg_log_email.dart';
import 'package:kitob_ol/login/service/reg_log_number.dart';
import 'package:kitob_ol/login/ui/login_email.dart';
import 'package:kitob_ol/widget/app_bar.dart';
import 'package:kitob_ol/widget/my_botton_text.dart';
import 'package:kitob_ol/widget/my_text_field.dart';
import 'package:kitob_ol/widget/text_class.dart';

class PhoneInputFormatter extends TextInputFormatter {
  TextClass textClass = TextClass();
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Prefix ("+998") ni saqlash
    if (!newValue.text.startsWith('+998')) {
      return oldValue;
    }

    // Faqat "+998" dan keyin kiritilgan qismini olish
    String numberPart = newValue.text.substring(4);

    // Raqamlarni formatlaymiz
    String formattedNumber = textClass
        .formatPhoneNumber(numberPart); // formatPhoneNumber(numberPart);

    // To'liq natijani qaytarish
    String finalResult = '+998 $formattedNumber';

    return TextEditingValue(
      text: finalResult,
      selection: TextSelection.collapsed(offset: finalResult.length),
    );
  }
}

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
  final phoneFormKey = GlobalKey<FormState>();
  final emailFormKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool _isPhoneError = false;
  bool _isEmailError = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    number = TextEditingController(text: "+998 ");
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
          children: [_firstPage(), _secondPage()],
        ),
      ),
      persistentFooterButtons: [_buildButtons(_tabController.index == 0)],
    );
  }

  Widget _firstPage() {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: phoneFormKey,
          child: Column(
            children: [
              Text("authNumber".tr()),
              const SizedBox(height: 10),
              Text('pasNumber'.tr()),
              TextFormField(
                controller: number,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  PhoneInputFormatter(),
                  LengthLimitingTextInputFormatter(
                      17), // "+998 XX XXX XX XX" maksimum 17 belgi
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _isPhoneError ? Colors.red : Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _isPhoneError ? Colors.red : Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  errorText: _isPhoneError
                      ? 'Iltimos, to\'g\'ri telefon raqamini kiriting'
                      : null,
                  prefixText:
                      '', // +998 qismi controller'da saqlanadi va o'chirib bo'lmaydi
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || value == '+998 ') {
                    return 'Telefon raqamini kiriting';
                  }

                  // Faqat raqamlarni olish
                  String digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');

                  // +998 dan tashqari kamida 9 raqam kiritilgan bo'lishi kerak
                  if (digitsOnly.length < 12) {
                    return 'To\'liq telefon raqamini kiriting';
                  }

                  return null;
                },
                onChanged: (value) {
                  // Prefix (+998) ni tekshirish va saqlash
                  if (!value.startsWith('+998')) {
                    number.text = '+998 ' + value.replaceAll('+998', '');
                    number.selection = TextSelection.fromPosition(
                        TextPosition(offset: number.text.length));
                  }

                  setState(() {
                    _isPhoneError = false;
                  });
                },
              ),
            ],
          ),
        ));
  }

  Widget _secondPage() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: emailFormKey,
        child: Column(
          children: [
            Text("authEmail".tr()),
            const SizedBox(height: 10),
            TextFormField(
              controller: email,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "email".tr(),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _isEmailError ? Colors.red : Colors.blue,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _isEmailError ? Colors.red : Colors.grey,
                    width: 1.0,
                  ),
                ),
                errorText: _isEmailError
                    ? 'Iltimos, to\'g\'ri email manzilini kiriting'
                    : null,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email manzilini kiriting';
                }
                if (!AppValidation.emailValidate(value)) {
                  return 'Noto\'g\'ri email formati';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _isEmailError = false;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons(bool isNumber) {
    return isLoading
        ? const Center(child: CircularProgressIndicator(color: kBlack))
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyElevedButtonBorder(
                width: MediaQuery.of(context).size.width * .45,
                onTap: () {
                  Navigator.of(context).pop();
                },
                text: "pascancel".tr(),
              ),
              MyBottonText(
                onLongPress: () {
                  final controller = isNumber ? number : email;
                  OnDableTap().onDoubleTap(controller.text, context);
                },
                width: MediaQuery.of(context).size.width * .45,
                textColor: kWhite,
                onTap: () async {
                  if (isNumber) {
                    _validatePhone();
                  } else {
                    _validateEmail();
                  }
                },
                text: "pasNext".tr(),
                boxColor: imageColor,
              ),
            ],
          );
  }

  void _validatePhone() {
    if (phoneFormKey.currentState!.validate()) {
      setState(() {
        _isPhoneError = false;
        isLoading = true;
      });

      // Telefon raqamidan bo'shliqlarni olib tashlash va kerakli formatga o'tkazish
      String phoneText = number.text.trim();
      String digitsOnly = phoneText.replaceAll(RegExp(r'[^\d]'), '');

      // Agar +998 bilan boshlanmasa, qo'shish
      String formattedNumber = digitsOnly.startsWith('998')
          ? digitsOnly.substring(3) // 998 dan so'ng
          : digitsOnly;

      RegisterApiPhone()
          .loginUserPhone("+998$formattedNumber", context)
          .then((_) {
        setState(() => isLoading = false);
      }).catchError((error) {
        setState(() {
          isLoading = false;
          _showSnackBar("Ro'yxatdan o'tishda xatolik yuz berdi");
        });
      });
    } else {
      setState(() {
        _isPhoneError = true;
      });
      _showSnackBar("phone".tr());
    }
  }

  void _validateEmail() {
    if (emailFormKey.currentState!.validate()) {
      setState(() {
        _isEmailError = false;
        isLoading = true;
      });

      RegisterApiEmail().loginUserEmail(email.text, context).then((_) {
        setState(() => isLoading = false);
      }).catchError((error) {
        setState(() {
          isLoading = false;
          _showSnackBar("Ro'yxatdan o'tishda xatolik yuz berdi");
        });
      });
    } else {
      setState(() {
        _isEmailError = true;
      });
      _showSnackBar("email".tr());
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
