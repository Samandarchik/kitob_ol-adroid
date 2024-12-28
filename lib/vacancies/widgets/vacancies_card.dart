import 'package:flutter/material.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/text_style.dart';
import 'package:kitob_ol/widget/text_class.dart';

class VacanciesCard extends StatelessWidget {
  final String vacancie;
  final String cityName;
  final String workingStyles;
  final String workingTypes;
  final int salaryFrom;
  final int salaryTo;
  final VoidCallback onTap;
  const VacanciesCard(
      {super.key,
      required this.cityName,
      required this.vacancie,
      required this.workingStyles,
      required this.workingTypes,
      required this.salaryFrom,
      required this.salaryTo,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        margin: EdgeInsets.all(20),
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
                        vacancie,
                        style: kTSFWB18.copyWith(fontSize: 20),
                      ),
                    ),
                    Text(
                      cityName,
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
                        Icons.favorite_outline,
                        color: kred,
                      )),
                )
              ],
            ),
            SizedBox(height: 10),
            Text("• $workingStyles"),
            Text("• $workingTypes"),
            SizedBox(
              height: 20,
            ),
            Text(
              "${TextClass().formatNumberWithSpaces(salaryFrom)} ~ ${TextClass().formatNumberWithSpaces(salaryTo)} So'm",
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
