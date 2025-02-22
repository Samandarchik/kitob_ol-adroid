import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/profile_service.dart';
import 'package:kitob_ol/text_style.dart';
import 'package:kitob_ol/widget/my_botton_text.dart';
import 'package:kitob_ol/widget/my_text_field.dart';

class MyProfileEdit extends StatefulWidget {
  final String name;
  final String lastName;
  final String birthday;
  final String number;
  final String email;
  final String imageUrl;
  final String role;

  const MyProfileEdit({
    super.key,
    required this.name,
    required this.lastName,
    required this.birthday,
    required this.number,
    required this.email,
    required this.imageUrl,
    required this.role,
  });

  @override
  State<MyProfileEdit> createState() => _MyProfileEditState();
}

class _MyProfileEditState extends State<MyProfileEdit> {
  late final TextEditingController name;
  late final TextEditingController lastName;
  late final TextEditingController birthday;
  late final TextEditingController phoneNumber;
  late final TextEditingController email;
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.name);
    lastName = TextEditingController(text: widget.lastName);
    birthday = TextEditingController(text: widget.birthday);
    phoneNumber = TextEditingController(text: widget.number);
    email = TextEditingController(text: widget.email);
  }

  @override
  void dispose() {
    name.dispose();
    lastName.dispose();
    birthday.dispose();
    phoneNumber.dispose();
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Mening profilim",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * .072,
                          ),
                        ),
                        IconButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll<Color>(
                                Colors.grey.shade300),
                          ),
                          onPressed: () {},
                          icon: const Icon(Icons.logout),
                        ),
                      ],
                    ),
                    Divider(),
                    SizedBox(height: 20),
                    Stack(
                      children: [
                        Container(
                          height: 200,
                          width: 200,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/image/image.png"),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 10,
                          child: GestureDetector(
                            onTap: () => _selectDate(context),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 3, color: Colors.white),
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                height: 25,
                                width: 25,
                                "assets/icon/Gallery Edit.svg",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
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
                    SizedBox(height: 15),
                    TextField(
                      onTap: () {
                        _selectDate(context);
                      },
                      controller: birthday,
                      keyboardType: TextInputType.datetime,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kBlack),
                        ),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(8),
                        labelText: "Tug'gilgan Kun",
                        hintText: "1950-12-31",
                        labelStyle: kTSFS16,
                      ),
                    ),
                    MyTextField(
                      controller: phoneNumber,
                      label: "Telefon raqam",
                      textInputType: TextInputType.phone,
                    ),
                    MyTextField(
                      controller: email,
                      label: "Email",
                      textInputType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyElevedButtonBorder(
                    width: size.width * .45,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    text: "Bekor qilish",
                  ),
                  MyBottonText(
                    width: size.width * .45,
                    text: "Saqlash",
                    boxColor: imageColor,
                    textColor: kWhite,
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Malumotlarni yangilash"),
                              content:
                                  const Text("Malumotlarni yangilansinmi?"),
                              actions: [
                                GestureDetector(
                                    onTap: () => Navigator.pop(context),
                                    child: const Text("Yo'q  ")),
                                SizedBox(width: 10),
                                GestureDetector(
                                    onTap: () async {
                                      updateProfile();
                                    },
                                    child: const Text("Ha  ")),
                              ],
                            );
                          });
                    },
                  ),
                ],
              ),
            ),
          ],
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
        birthday.text =
            "${_picked.year}-${_picked.month.toString().padLeft(2, '0')}-${_picked.day.toString().padLeft(2, '0')}";
      });
    }
    print(birthday.text);
  }

  Future<void> updateProfile() async {
    await ProfileService().updateProfile(
        UserDataModel(name.text, lastName.text, birthday.text, phoneNumber.text,
            email.text, imageUrl, "user"),
        context);
    Navigator.pop(context);
  }
}
