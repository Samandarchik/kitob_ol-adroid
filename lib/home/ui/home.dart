import 'package:flutter/material.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/home/ui/ish.dart';
import 'package:kitob_ol/home/ui/book_list.dart';
import 'package:kitob_ol/home/service/filter_controller.dart';
import 'package:kitob_ol/provider_auth.dart';
import 'package:kitob_ol/text_style.dart';
import 'package:kitob_ol/widget/app_bar.dart';
import 'package:kitob_ol/widget/drawer.dart';
import 'package:kitob_ol/widget/my_botton_text.dart';
import 'package:kitob_ol/widget/slider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool book = true; // Initially, we show books by default

  @override
  Widget build(BuildContext context) {
    print("HomePage ${Provider.of<AuthProvider>(context).token}");
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const MyAppBar(),
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MySlider(),
              const SizedBox(height: 20),
              MyElevedButtonBorder(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FilterPage()),
                  );
                },
                text: "Filter",
              ),

              const SizedBox(height: 10),
              // Book button
              MyBottonText(
                top: 10,
                textColor: book ? kGrey : imageColor,
                onTap: () {
                  setState(() {
                    book = true; // Switch to show books
                  });
                },
                text: "Kitoblar",
                boxColor: book ? imageColor : kGrey,
              ),
              // Job button
              MyBottonText(
                top: 10,
                textColor: book ? imageColor : kGrey,
                onTap: () {
                  setState(() {
                    book = false; // Switch to show jobs
                  });
                },
                text: "Ish",
                boxColor: book ? kGrey : imageColor,
              ),
              const SizedBox(height: 18),
              Text(
                book ? "Kitoblar ro'yxati" : "Ishlar ro'yxati",
                style: kTSFWB18, // This defines the text style
              ),
              SizedBox(height: 10),
              book ? const BookList() : const IshList(),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
