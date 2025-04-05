import 'package:flutter/material.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/home/service/ish.dart';
import 'package:kitob_ol/text_style.dart';
import 'package:kitob_ol/vacancies/ui/vacancies_details.dart';
import 'package:kitob_ol/widget/text_class.dart';

class VacanciesCard extends StatelessWidget {
  final Ish ish;
  final VoidCallback onTap;
  const VacanciesCard({super.key, required this.ish, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VacanciesDetails(vacancies: ish)));
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
                      ish.cityName["uz"]!,
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
            Text(
                "• ${ish.workingStyles == "offline" ? "Masofaviy" : 'Ofisda'}"),
            Text(
                "• ${ish.workingTypes == "full_time" ? "To'liq ish kuni" : "Malum soatlarda"}"),
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
