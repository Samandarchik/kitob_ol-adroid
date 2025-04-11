import 'package:flutter/material.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/home/service/book_service.dart';
import 'package:kitob_ol/home/service/ish.dart';
import 'package:kitob_ol/home/service/ish_service.dart';
import 'package:kitob_ol/home_vacancies_card_widget.dart';

class IshList extends StatefulWidget {
  const IshList({super.key});

  @override
  _IshListState createState() => _IshListState();
}

class _IshListState extends State<IshList> {
  final VacancyService vacancyService = VacancyService();

  BookService bookService = BookService();
  late Future<List<Ish>> futureBooks;

  @override
  void initState() {
    super.initState();
    futureBooks = vacancyService.fetchIshs();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Ish>>(
      future: futureBooks,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: kGreyContainer,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("No vacansiya available"));
        } else if (snapshot.hasData) {
          List<Ish> jobs = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true, // 📌 ListView balandligini minimallashtiradi
            physics: NeverScrollableScrollPhysics(),
            itemCount: jobs.length,
            itemBuilder: (context, index) {
              var job = jobs[index];
              return HomeVacanciesCardWidget(
                ish: job,
              );
            },
          );
        } else {
          return Center(child: Text("No vacansiya available"));
        }
      },
    );
  }
}
