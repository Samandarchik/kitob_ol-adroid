import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/profile/profile_edit.dart';
import 'package:kitob_ol/widget/my_botton_text.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text("Mening profilim"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(kGrey)),
                onPressed: () {},
                icon: const Icon(Icons.logout)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
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
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 3, color: Colors.white),
                                color: Colors.black,
                                shape: BoxShape.circle),
                            child: SvgPicture.asset(
                                height: 25,
                                width: 25,
                                "assets/icon/Gallery Edit.svg")))
                  ],
                ),
              ),
              myText("Ism", "Samandar"),
              myText("Familiya", "Ibragimov"),
              myText("Tug'ulgan sana", "07.07.1997"),
              myText("Telefon raqam", "+998 88 155 72 73"),
              myText("Email manzil", "Nasibjon007@gmail.com"),
              SizedBox(
                height: 10,
              ),
              MyElevedButtonBorder(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyProfileEdit()));
                  },
                  text: "Edit"),
              SizedBox(height: 30)
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
        const SizedBox(
          height: 10,
        ),
        Text(" $h1"),
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          width: double.infinity,
          decoration: BoxDecoration(color: kGrey),
          child: Text(
            "  $p",
            style: TextStyle(fontSize: 18),
          ),
          padding: EdgeInsets.symmetric(vertical: 15),
        )
      ],
    );
  }
}
