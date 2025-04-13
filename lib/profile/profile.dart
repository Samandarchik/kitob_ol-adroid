import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/core/data/local/token_storage.dart';
import 'package:kitob_ol/core/di/di.dart';
import 'package:kitob_ol/home/model/user_info_model.dart';
import 'package:kitob_ol/home/ui/home.dart';
import 'package:kitob_ol/login/ui/register.dart';
import 'package:kitob_ol/profile/profile_edit.dart';
import 'package:kitob_ol/profile/user_data_register.dart';
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
  String token = sl<TokenStorage>().getToken();
  UserDataModel? userData;
  bool userDataIsFull = true;
  final TokenStorage _authService = sl<TokenStorage>();

  @override
  void initState() {
    super.initState();

    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    if (token.isNotEmpty) {
      try {
        final profile = await ProfileService().fetchProfile();
        if (mounted) {
          setState(() {
            userData = profile;
            userDataNull();
          });
        }
      } catch (e) {
        print("Xatolik: $e");
      }
    }
  }

  void userDataNull() {
    if (userData?.name == null ||
        userData!.name!.isEmpty ||
        userData?.lastName == null ||
        userData!.lastName!.isEmpty ||
        userData?.birthday == null ||
        userData!.birthday!.isEmpty ||
        userData?.number == null ||
        userData!.number!.isEmpty ||
        userData?.email == null ||
        userData!.email!.isEmpty ||
        userData?.imageUrl == null ||
        userData!.imageUrl!.isEmpty) {
      // At least one field is empty or null
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return UserDataRegister(
          email: userData?.email,
          phoneNumber: userData?.number,
        );
      }));
    } else {
      setState(() {
        userDataIsFull = false;
        print("userDataIsFull false");
      });
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
                        showDialo();
                      })
                ]
              : null,
        ),
        body: token.isNotEmpty ? _buildProfileContent() : _buildLoginPrompt());
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
    if (userData == null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const Divider(),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(shape: BoxShape.circle, color: kGrey),
              ),
            ),
            myText("name".tr(), ""),
            myText("surname".tr(), ""),
            myText("birthday".tr(), ""),
            myText("phoneNumber".tr(), ""),
            myText("email".tr(), ""),
          ],
        ),
      );
    } else {
      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),
            _buildProfileImage(),
            myText("name".tr(), userData?.name ?? ""),
            myText("surname".tr(), userData?.lastName ?? ""),
            myText("birthday".tr(), userData?.birthday ?? ""),
            myText(
              "phoneNumber".tr(),
              TextClass().formatPhoneNumber(userData?.number ?? "998000000000"),
            ),
            myText("email".tr(), userData!.email ?? ""),
            const SizedBox(height: 10),
            MyElevedButtonBorder(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyProfileEdit(
                      user: userData!,
                    ),
                  ),
                );
              },
              text: "edit".tr(),
            ),
            const SizedBox(height: 30),
          ],
        ),
      );
    }
  }

  Widget _buildProfileImage() {
    return Center(
        child: ClipOval(
      child: Image.network(
        userData?.imageUrl ??
            "https://i.pinimg.com/736x/b2/66/f7/b266f7c8ecb53960c5eaa19d2a40dc41.jpg",
        height: MediaQuery.of(context).size.height * 0.25,
        width: MediaQuery.of(context).size.height * 0.25,
        errorBuilder: (context, error, stackTrace) => Icon(
          Icons.person,
          size: MediaQuery.of(context).size.height * 0.25,
        ),
      ),
    ));
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

  void showDialo() => showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            backgroundColor: kWhite,
            title: Text("exit".tr()),
            content: const Text("Chiqishni tasdiqlaysizmi?"),
            actions: [
              GestureDetector(
                  onTap: () {
                    _authService.removeToken();
                    Navigator.pop(context);
                    setState(() {
                      _authService.removeToken();
                      _authService.removeRefreshToken();

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                          (route) => false);
                    });
                  },
                  child: Text("yes".tr())),
              GestureDetector(
                  onTap: () => Navigator.pop(context), child: Text("no".tr()))
            ]);
      });
}
