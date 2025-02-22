import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/login/page/register.dart';
import 'package:kitob_ol/main.dart';
import 'package:kitob_ol/profile/profile_edit.dart';
import 'package:kitob_ol/profile_service.dart';
import 'package:kitob_ol/text_style.dart';
import 'package:kitob_ol/widget/my_botton_text.dart';
import 'package:kitob_ol/widget/text_class.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  bool isRegister = AuthService.token == null;
  UserDataModel? userData;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    try {
      final profile = await ProfileService().fetchProfile();
      setState(() {
        userData = profile;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isRegister
        ? Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "Mening profilim",
                style: kTSFWB18,
              ),
            ),
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Tizimga kirish",
                  style: kTSFWB18,
                ),
                Text(
                  "Mening profilim faqatgina login \nqilgan foydalanuvchilar uchun",
                  style: kTSFS16,
                ),
                Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: MyBottonText(
                      boxColor: imageColor,
                      textColor: kWhite,
                      width: MediaQuery.of(context).size.width * .6,
                      text: "Ro'yxatdan o'tish",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Register()),
                        );
                      },
                    ))
              ],
            )),
          ) // Agar token yo‘q bo‘lsa, loading ko‘rsatish
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: const Text("Mening profilim"),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(kGrey),
                    ),
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Ro'yxatdan chiqish"),
                              content: const Text(
                                  "Ro'yxatdan chiqishni hohlaysizmi?"),
                              actions: [
                                GestureDetector(
                                    onTap: () => Navigator.pop(context),
                                    child: const Text("Yo'q  ")),
                                SizedBox(width: 10),
                                GestureDetector(
                                    onTap: () async {
                                      Navigator.pop(context);
                                      await AuthService.removeToken();
                                      setState(() {
                                        isRegister = true;
                                      });
                                    },
                                    child: const Text("Ha  ")),
                              ],
                            );
                          });
                    }, // Logout funksiyasini qo‘shing
                    icon: const Icon(Icons.logout),
                  ),
                )
              ],
            ),
            body: userData == null
                ? Center(child: Text("Malumotlar yuklanayapti"))
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(),
                          Center(
                            child: Stack(
                              children: [
                                Container(
                                  height: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: userData!.imageUrl != "null" &&
                                              userData!.imageUrl !=
                                                  "/assets/annoymouse_user-hkEn8bkU.jpg"
                                          ? NetworkImage(
                                              userData?.imageUrl ?? "",
                                            )
                                          : const AssetImage(
                                                  "assets/image/image.png")
                                              as ImageProvider,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 10,
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 3, color: Colors.white),
                                      color: Colors.black,
                                      shape: BoxShape.circle,
                                    ),
                                    child: SvgPicture.asset(
                                      height: 25,
                                      width: 25,
                                      "assets/icon/Gallery Edit.svg",
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          myText("Ism", userData!.name),
                          myText("Familiya", userData!.lastName),
                          myText("Tug‘ilgan sana", userData!.birthday),
                          myText("Telefon raqam",
                              TextClass().formatPhoneNumber(userData!.number)),
                          myText("Email manzil", userData!.email),
                          const SizedBox(height: 10),
                          MyElevedButtonBorder(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyProfileEdit(
                                        name: userData!.name,
                                        lastName: userData!.lastName,
                                        birthday: userData!.birthday,
                                        number: userData!.number,
                                        email: userData!.email,
                                        imageUrl: userData?.imageUrl ?? "",
                                        role: userData!.role)),
                              );
                            },
                            text: "Edit",
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
          );
  }

  Column myText(String h1, String p) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(" $h1"),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          width: double.infinity,
          decoration: const BoxDecoration(color: kGrey),
          child: Text(
            "  $p",
            style: const TextStyle(fontSize: 18),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ],
    );
  }
}
