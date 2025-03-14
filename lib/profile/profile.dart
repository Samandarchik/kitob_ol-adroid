import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/home/model/user_info_model.dart';
import 'package:kitob_ol/login/ui/register.dart';
import 'package:kitob_ol/profile/profile_edit.dart';
import 'package:kitob_ol/profile_service.dart';
import 'package:kitob_ol/provider_auth.dart';
import 'package:kitob_ol/text_style.dart';
import 'package:kitob_ol/widget/my_botton_text.dart';
import 'package:kitob_ol/widget/text_class.dart';
import 'package:provider/provider.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  UserDataModel? userData;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    if (Provider.of<AuthProvider>(context, listen: false).token != null) {
      try {
        final profile = await ProfileService()
            .fetchProfile(Provider.of<AuthProvider>(context, listen: false));
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
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    bool isRegister = authProvider.token != null;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Mening profilim"),
          actions: [
            if (isRegister)
              IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              backgroundColor: kWhite,
                              title: const Text("Chiqish"),
                              content: const Text("Chiqishni tasdiqlaysizmi?"),
                              actions: [
                                GestureDetector(
                                    onTap: () {
                                      authProvider.removeToken();
                                      Navigator.pop(context);
                                      setState(() {
                                        isRegister = false;
                                      });
                                    },
                                    child: const Text("Ha")),
                                GestureDetector(
                                    onTap: () => Navigator.pop(context),
                                    child: const Text("Yo'q"))
                              ]);
                        });
                  })
          ],
        ),
        body: Consumer<AuthProvider>(builder: (context, authProvider, child) {
          return authProvider.token != null
              ? _buildProfileContent(authProvider)
              : _buildLoginPrompt();
        }) // isRegister ? _buildProfileContent(authProvider) : _buildLoginPrompt(),
        );
  }

  Widget _buildLoginPrompt() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Tizimga kirish", style: kTSFWB18),
          Text(
            "Mening profilim faqatgina login qilgan foydalanuvchilar uchun",
            style: kTSFS16,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          MyBottonText(
            boxColor: imageColor,
            textColor: kWhite,
            width: MediaQuery.of(context).size.width * 0.6,
            text: "Ro'yxatdan o'tish",
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

  Widget _buildProfileContent(AuthProvider authProvider) {
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
