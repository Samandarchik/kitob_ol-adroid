import 'package:flutter/material.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/fav.dart';
import 'package:kitob_ol/profile/profile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xff2C3033),
      child: SafeArea(
        child: Container(
          color: const Color(0xff2C3033),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/image/kiton_logo.png"),
              SizedBox(
                height: 10,
              ),
              ListTile(
                leading: Icon(
                  Icons.bookmark_outline,
                  color: kWhite,
                ),
                title: const Text(
                  'Saqlanganlar',
                  style: TextStyle(color: kWhite),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FavoriteGet()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.person_outline, color: kWhite),
                title: const Text(
                  'Mening profilim',
                  style: TextStyle(color: kWhite),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyProfile()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.language, color: kWhite),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Til',
                      style: TextStyle(color: kWhite),
                    ),
                    const Icon(Icons.arrow_drop_down, color: kWhite),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Tez orada"),
                  ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
