import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/home/service/ish.dart';
import 'package:kitob_ol/text_style.dart';
import 'package:kitob_ol/widget/my_botton_text.dart';
import 'package:kitob_ol/widget/text_class.dart';
import 'package:url_launcher/url_launcher.dart';

class VacanciesDetails extends StatelessWidget {
  final Ish vacancies;
  const VacanciesDetails({
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
                  "vacancyDetail".tr(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  vacancies.description,
                  style: kTSFWB18,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "vacancyPrice".tr(),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "${TextClass().formatNumberWithSpaces(vacancies.salaryFrom)} ~ ${TextClass().formatNumberWithSpaces(vacancies.salaryTo)} ${"sum".tr()}",
                  style: kTSFWB18,
                ),
                myText(
                    "vacancyTime".tr(),
                    vacancies.workingTypes == "part_time"
                        ? "Doimiy"
                        : "Ma'lum soatlarda"),
                myText("vacancyType".tr(), vacancies.description),
                SizedBox(height: 10),
                Align(
                    alignment: Alignment.topRight,
                    child:
                        Text("${"viewsNumber".tr()} ${vacancies.viewCount}")),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: MyBottonText(
                bottom: 20,
                text: "call".tr(),
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
