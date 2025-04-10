import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/home/service/book_service.dart';
import 'package:kitob_ol/home/service/ish.dart';
import 'package:kitob_ol/text_style.dart';
import 'package:kitob_ol/vacancies/ui/vacancies_details.dart';
import 'package:kitob_ol/widget/add_remove.dart';
import 'package:kitob_ol/widget/text_class.dart';

class VacanciesCard extends StatefulWidget {
  final Ish ish;

  const VacanciesCard({
    super.key,
    required this.ish,
  });

  @override
  State<VacanciesCard> createState() => _VacanciesCardState();
}

class _VacanciesCardState extends State<VacanciesCard> {
  final TextClass textClass = TextClass();
  final BookService bookService = BookService();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VacanciesDetails(vacancies: widget.ish)));
        await bookService.getVacancy(widget.ish.id);
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
                        widget.ish.title,
                        style: kTSFWB18.copyWith(fontSize: 20),
                      ),
                    ),
                    Text(
                      widget.ish.cityName[context.locale.languageCode]!,
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Color(0xffeeeeee)),
                  child: IconButton(
                      onPressed: () async {
                        if (widget.ish.isFavorite) {
                          print("Add");

                          final bool isAdded = await addRemoveVac(
                              widget.ish.id, widget.ish.isFavorite);
                          setState(() {
                            isAdded
                                ? widget.ish.isFavorite = !widget.ish.isFavorite
                                : null;
                          });
                          print(
                              "Vacancy id: ${widget.ish.id} Is ${widget.ish.isFavorite}");
                        } else {
                          print("Remove");
                          addRemoveVac(widget.ish.id, widget.ish.isFavorite);
                          setState(() {
                            widget.ish.isFavorite = !widget.ish.isFavorite;
                          });
                          print(
                              "Vacancy id: ${widget.ish.id} Is ${widget.ish.isFavorite}");
                        }
                      },
                      icon: Icon(
                        widget.ish.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_outline,
                        color: kred,
                      )),
                )
              ],
            ),
            SizedBox(height: 10),
            Text(
                "• ${widget.ish.workingStyles == "offline" ? "online".tr() : 'offline'.tr()}"),
            Text(
                "• ${widget.ish.workingTypes == "full_time" ? "full_time".tr() : "part_time".tr()}"),
            SizedBox(
              height: 20,
            ),
            Text(
              "${textClass.formatNumberWithSpaces(widget.ish.salaryFrom)} ~ ${textClass.formatNumberWithSpaces(widget.ish.salaryTo)} So'm",
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
