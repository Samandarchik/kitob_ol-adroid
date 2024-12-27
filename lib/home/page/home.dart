import 'package:flutter/material.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/filter_controller/filter_controller.dart';
import 'package:kitob_ol/text_style.dart';
import 'package:kitob_ol/widget/app_bar.dart';
import 'package:kitob_ol/widget/drawer.dart';
import 'package:kitob_ol/widget/my_botton_text.dart';
import 'package:kitob_ol/widget/slider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(automaticallyImplyLeading: false, title: const MyAppBar()),
        drawer: const CustomDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const MySlider(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    MyElevedButtonBorder(
                      onTap: () {},
                      text: "See more",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyBottonText(
                        top: 10,
                        textColor: kWhite,
                        onTap: () {},
                        text: "Kitoblar",
                        boxColor: imageColor),
                    MyBottonText(
                      top: 10,
                      textColor: kBlack,
                      onTap: () {},
                      text: "Ish",
                      boxColor: kGrey,
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    const Text(
                      "Filter",
                      style: kTSFWB18,
                    ),
                    const FilterController(),
                    const SizedBox(
                      height: 80,
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
