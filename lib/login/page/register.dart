import 'package:flutter/material.dart';
import 'package:kitob_ol/color.dart';
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
  TextClass textClass = TextClass();
  TextEditingController number = TextEditingController();
  TextEditingController email = TextEditingController();

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
              padding: EdgeInsets.zero,
              tabs: [
                Tab(
                  child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Telefon raqam",
                        textAlign: TextAlign.center,
                      )),
                ),
                Tab(
                  child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Email",
                        textAlign: TextAlign.center,
                      )),
                )
              ]),
        ),
        body: SafeArea(
          child: TabBarView(children: [
            register(
                context,
                "Telefon raqamingizni kiriting",
                "99 123 45 67",
                "+998 ",
                "Avtorizatsiya qilish uchun iltimos telefon raqamingini kiriting!",
                true,
                TextInputType.number,
                number, (value) {
              setState(() {
                // Formatlash va TextController ga qaytarish
                number.text = textClass.formatPhoneNumber(value);
                // Kursorni oxiriga qo'yish
                number.selection =
                    TextSelection.collapsed(offset: number.text.length);
              });
            }),
            register(
                context,
                "Email manzilingizni kiriting",
                "example@gmail.com",
                "",
                "Avtorizatsiya qilish uchun iltimos email manzilingizni kiriting!",
                false,
                TextInputType.emailAddress,
                email,
                (value) {}),
          ]),
        ),
      ),
    );
  }

  Container register(
      BuildContext context,
      String h1,
      String text,
      String label,
      String p,
      bool number,
      TextInputType type,
      TextEditingController controller,
      void Function(String)? onChanged) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          MyTextFieldFilled(
              onChanged: onChanged,
              text: text,
              maxLens: true,
              maxLines: number ? 12 : null,
              border: false,
              next: TextInputAction.done,
              hint: label,
              controller: controller,
              label: h1,
              textInputType: type),
          const SizedBox(
            height: 14,
          ),
          Text(
            p,
            style: kTSFS16,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyElevedButtonBorder(
                  width: MediaQuery.of(context).size.width * .45,
                  onTap: () {},
                  text: "Bekor qilish"),
              MyBottonText(
                  width: MediaQuery.of(context).size.width * .45,
                  textColor: kWhite,
                  onTap: number
                      ? () {
                          if (controller.text.length == 12) {
                            String rawNumber =
                                controller.text.replaceAll(' ', '');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("Ilimos nomerni to'ldiring")));
                          }
                        }
                      : () {
                          if (controller.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Email masnzil kiriting")));
                          }
                        },
                  text: "Keyingisi",
                  boxColor: imageColor),
            ],
          )
        ],
      ),
    );
  }
}
