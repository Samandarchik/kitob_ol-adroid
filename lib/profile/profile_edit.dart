import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/text_style.dart';
import 'package:kitob_ol/widget/my_botton_text.dart';

import 'package:kitob_ol/widget/my_text_field.dart';

class MyProfileEdit extends StatefulWidget {
  const MyProfileEdit({super.key});

  @override
  State<MyProfileEdit> createState() => _MyProfileEditState();
}

class _MyProfileEditState extends State<MyProfileEdit> {
  TextEditingController name = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController birthday = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Mening profilim",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * .072),
                    ),
                    IconButton(
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll<Color>(
                                Colors.grey.withOpacity(.3))),
                        onPressed: () {},
                        icon: const Icon(Icons.logout))
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Stack(
                      children: [
                        Container(
                          height: 200,
                          width: 200,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage("assets/image/image.png"))),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 10,
                            child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 3, color: Colors.white),
                                    color: Colors.black,
                                    shape: BoxShape.circle),
                                child: SvgPicture.asset(
                                    height: 25,
                                    width: 25,
                                    "assets/icon/Gallery Edit.svg")))
                      ],
                    ),
                    MyTextField(
                      controller: name,
                      label: "Ism",
                      textInputType: TextInputType.text,
                    ),
                    MyTextField(
                      controller: lastName,
                      label: "Familiya",
                      textInputType: TextInputType.text,
                    ),
                    MyTextField(
                      controller: name,
                      label: "Tug'ilgan sana",
                      textInputType: TextInputType.datetime,
                    ),
                    MyTextField(
                      controller: email,
                      label: "Email manzili",
                      textInputType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      onTap: () {
                        _selectDate(context);
                      },
                      onChanged: (value) {
                        _selectDate(context);
                      },
                      controller: birthday,
                      keyboardType: TextInputType.datetime,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: kBlack)),
                          border: const OutlineInputBorder(),
                          contentPadding: const EdgeInsets.all(8),
                          labelText: "Tug'gilgan Kun",
                          hintText: "1950-12-31",
                          labelStyle: kTSFS16),
                    ),
                    MyTextField(
                        controller: phoneNumber,
                        prefixText: "+998 ",
                        label: "Telefon raqam",
                        textInputType: TextInputType.phone),
                    MyTextField(
                      controller: email,
                      label: "Email",
                      textInputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyElevedButtonBorder(
                            width: size.width * .45,
                            onTap: () {
                              Navigator.pop(context);
                            },
                            text: "Bekor qilish"),
                        MyBottonText(
                            width: size.width * .45,
                            text: "Saqlash",
                            boxColor: imageColor,
                            textColor: kWhite,
                            onTap: () {})
                      ],
                    ),
                  ],
                )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(context) async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1960),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: kBlack, // Change selected date color
              onPrimary: kWhite, // Text color on selected date
              surface: kWhite, // Header background color
              onSurface: Colors.black, // Default text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: kBlack, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (_picked != null) {
      setState(() {
        birthday.text = _picked.toString().split(" ")[0];
      });
    }
  }
}
/**
 * builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue, // Tanlangan sananing rangi
            accentColor: Colors.blueAccent, // Tanlov uchun rang
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary), // Tugma matnining rangi
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.red, // Tanlangan sana uchun matn rangi
              ),
            ),
            colorScheme: ColorScheme.light(primary: Colors.blue),
            dialogBackgroundColor: Colors.white, // Dialog fon rangi
            textTheme: TextTheme(
              headline4: TextStyle(color: Colors.green, fontWeight: FontWeight.bold), // Katta sarlavha rangini o'zgartirish
            ),
          ),
 */