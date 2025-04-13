import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/home/model/job_model.dart';
import 'package:kitob_ol/text_style.dart';
import 'package:kitob_ol/vacansiya_favorite.dart';
import 'package:kitob_ol/widget/text_class.dart';

class FavoreteVacanDetail extends StatelessWidget {
  final JobModel ish;
  const FavoreteVacanDetail({
    super.key,
    required this.ish,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VacansiyaFavoriteDetail(vacancies: ish)));
      },
      child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        decoration: BoxDecoration(
            color: kGreyContainer, borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .67,
                      child: Text(
                        ish.title,
                        style: kTSFWB18.copyWith(fontSize: 20),
                      ),
                    ),
                    Text(
                      ish.cityName[context.locale.languageCode]!,
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Color(0xffeeeeee)),
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite,
                        color: kred,
                      )),
                )
              ],
            ),
            SizedBox(height: 10),
            Text(
                "• ${ish.workingStyles == "offline" ? "offline".tr() : 'online'.tr()}"),
            Text(
                "• ${ish.workingTypes == "full_time" ? "full_time".tr() : "part_time".tr()}"),
            SizedBox(
              height: 20,
            ),
            Text(
              "${TextClass().formatNumberWithSpaces(ish.salaryFrom)} ~ ${TextClass().formatNumberWithSpaces(ish.salaryTo)} So'm",
              style: TextStyle(
                  color: kred, fontWeight: FontWeight.bold, fontSize: 19),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
