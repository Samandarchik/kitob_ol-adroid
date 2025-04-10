import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kitob_ol/book_create.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/core/data/local/token_storage.dart';
import 'package:kitob_ol/core/di/di.dart';
import 'package:kitob_ol/fav.dart';
import 'package:kitob_ol/profile/profile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});
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
              SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.bookmark_outline, color: kWhite),
                title: Text('save'.tr(), style: TextStyle(color: kWhite)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FavoriteGet()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.person_outline, color: kWhite),
                title: Text('profile'.tr(), style: TextStyle(color: kWhite)),
                onTap: () async {
                  bool? token =
                      sl<TokenStorage>().getToken() == null ? false : true;
                  Navigator.pop(context);
                  print("token: $token");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyProfile()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.language, color: kWhite),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('language'.tr(), style: TextStyle(color: kWhite)),
                    const Icon(Icons.arrow_drop_down, color: kWhite),
                  ],
                ),
                onTap: () => _showLanguageSelection(context),
              ),
              ListTile(
                leading: const Icon(Icons.book, color: kWhite),
                title: Text('addBook'.tr(), style: TextStyle(color: kWhite)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BookCreatePage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLanguageSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Color(0xff2C3033),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.language, color: kWhite),
              title: Text('O‘zbekcha', style: TextStyle(color: kWhite)),
              onTap: () {
                Navigator.pop(context);
                context.setLocale(const Locale('uz', "UZ"));
                // Tilni o‘zbekchaga o‘zgartirish kodi
              },
            ),
            ListTile(
              leading: Icon(Icons.language, color: kWhite),
              title: Text('English', style: TextStyle(color: kWhite)),
              onTap: () {
                Navigator.pop(context);
                // Tilni inglizchaga o‘zgartirish kodi
                context.setLocale(const Locale('en', "US"));
              },
            ),
            ListTile(
              leading: Icon(Icons.language, color: kWhite),
              title: Text('Русский', style: TextStyle(color: kWhite)),
              onTap: () {
                Navigator.pop(context);
                context.setLocale(const Locale('ru', "RU"));
              },
            ),
          ],
        ),
      ),
    );
  }
}
