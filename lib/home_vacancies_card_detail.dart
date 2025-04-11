import 'package:flutter/material.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/home/service/ish.dart';
import 'package:kitob_ol/text_style.dart';
import 'package:kitob_ol/widget/my_botton_text.dart';
import 'package:kitob_ol/widget/text_class.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeVacanciesCardDetail extends StatelessWidget {
  final Ish vacancies;
  const HomeVacanciesCardDetail({
    super.key,
    required this.vacancies,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(vacancies.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ish haqida",
                  style: kTSFWB18,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Maosh",
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "${TextClass().formatNumberWithSpaces(vacancies.salaryFrom)} ~ ${TextClass().formatNumberWithSpaces(vacancies.salaryTo)} So'm",
                  style: kTSFWB18,
                ),
                myText(
                    "Ish vaqti",
                    vacancies.workingTypes == "part_time"
                        ? "Doimiy"
                        : "Ma'lum soatlarda"),
                myText("Ish turi", vacancies.description),
                SizedBox(height: 10),
                Align(
                    alignment: Alignment.topRight,
                    child: Text("Ko'rilgan: ${vacancies.viewCount}")),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: MyBottonText(
                bottom: 20,
                text: "Telefon qilish",
                boxColor: imageColor,
                textColor: kWhite,
                onTap: () async {
                  final Uri url =
                      Uri(scheme: "tel", path: vacancies.phoneNumber);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Not Number")));
                  }
                }),
          )
        ],
      ),
    );
  }

  Widget myText(String text, String text1) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(height: 20),
      Text(
        text,
        style: kTSFS16,
      ),
      Text(
        text1,
        style: kTSFWB18,
      ),
    ]);
  }
}
