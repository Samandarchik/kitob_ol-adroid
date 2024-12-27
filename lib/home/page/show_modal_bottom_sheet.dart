import 'package:flutter/material.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/text_style.dart';
import 'package:kitob_ol/widget/my_botton_text.dart';

class MyShowModalBottomSheet extends StatelessWidget {
  const MyShowModalBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * .33,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "  Murojat qilish",
              style: kTSFWB18,
            ),
          ),
          Divider(),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                decoration: BoxDecoration(color: kGrey, shape: BoxShape.circle),
                height: size.width * .2,
                width: size.width * .2,
                child: Icon(Icons.person),
              ),
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nasibjon Ikromov",
                      style: kTSFW,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text("Kosonsoy, Namangan"),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "+998 88 155 55 50",
                      style: kTSFW.copyWith(fontSize: 18),
                    ),
                  ],
                ),
              ),
              SizedBox(),
              SizedBox(),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          MyBottonText(
              width: size.width * .9,
              text: "Telefon qilish",
              boxColor: imageColor,
              textColor: kWhite,
              onTap: () {}),
        ],
      ),
    );
  }
}
