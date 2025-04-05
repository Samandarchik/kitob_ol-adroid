import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/home/model/user_info_model.dart';
import 'package:kitob_ol/home/ui/home.dart';
import 'package:kitob_ol/login/service/token.dart';
import 'package:kitob_ol/login/ui/register.dart';
import 'package:kitob_ol/profile/profile_edit.dart';
import 'package:kitob_ol/profile_service.dart';
import 'package:kitob_ol/provider_auth.dart';
import 'package:kitob_ol/text_style.dart';
import 'package:kitob_ol/widget/my_botton_text.dart';
import 'package:kitob_ol/widget/text_class.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  String? token = "";
  UserDataModel? userData;
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _authService.loadTokens().then((_) {
      _fetchUserProfile();
    });
  }

  Future<void> _fetchUserProfile() async {
    token = await _authService.getValidToken();

    if (token != null) {
      try {
        final profile = await ProfileService().fetchProfile(token!);
        if (mounted) {
          setState(() {
            userData = profile;
          });
        }
      } catch (e) {
        print("Xatolik: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("profile".tr(), style: kTSB),
          actions: userData != null
              ? [
                  IconButton(
                      icon: Icon(Icons.logout),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                  backgroundColor: kWhite,
                                  title: Text("exit".tr()),
                                  content:
                                      const Text("Chiqishni tasdiqlaysizmi?"),
                                  actions: [
                                    GestureDetector(
                                        onTap: () {
                                          _authService.clearTokens();
                                          Navigator.pop(context);
                                          setState(() {
                                            print("");
                                            userData = null;
                                            TokenStorage().removeToken();
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const HomePage()),
                                                (route) => false);
                                          });
                                        },
                                        child: Text("yes".tr())),
                                    GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: Text("no".tr()))
                                  ]);
                            });
                      })
                ]
              : null,
        ),
        body: token != null ? _buildProfileContent() : _buildLoginPrompt());
  }

  Widget _buildLoginPrompt() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("login".tr(), style: kTSFWB18),
          Text(
            "loginText".tr(),
            style: kTSFS16,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          MyBottonText(
            boxColor: imageColor,
            textColor: kWhite,
            width: MediaQuery.of(context).size.width * 0.6,
            text: "createAkaunt".tr(),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Register()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProfileContent() {
    return userData == null
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),
                _buildProfileImage(),
                myText("Ism", userData!.name),
                myText("Familiya", userData!.lastName),
                myText("Tug‘ilgan sana", userData!.birthday),
                myText(
                  "Telefon raqam",
                  TextClass().formatPhoneNumber(userData!.number),
                ),
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
                          role: userData!.role,
                        ),
                      ),
                    );
                  },
                  text: "Tahrirlash",
                ),
                const SizedBox(height: 30),
              ],
            ),
          );
  }

  Widget _buildProfileImage() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 100,
            backgroundImage: userData!.imageUrl != "null" &&
                    userData!.imageUrl != "/assets/annoymouse_user-hkEn8bkU.jpg"
                ? NetworkImage(userData!.imageUrl ?? "")
                : const AssetImage("assets/image/image.png") as ImageProvider,
          ),
          Positioned(
            bottom: 0,
            right: 10,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(width: 3, color: Colors.white),
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                "assets/icon/Gallery Edit.svg",
                height: 25,
                width: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column myText(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(title, style: kTSFWB18),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            decoration: BoxDecoration(
              color: kGrey,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              content,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
