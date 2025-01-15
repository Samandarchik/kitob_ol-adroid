import 'package:flutter/material.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/home/service/ish.dart';
import 'package:kitob_ol/home/service/ish_service.dart';
import 'package:kitob_ol/vacancies/widgets/vacancies_card.dart';

class IshList extends StatefulWidget {
  const IshList({super.key});

  @override
  _IshListState createState() => _IshListState();
}

class _IshListState extends State<IshList> {
  late Future<List<Ish>> futureBooks;

  @override
  void initState() {
    super.initState();
    futureBooks = IshService().fetchIshs();
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
              height: 200,
              decoration: BoxDecoration(
                color: kGreyContainer,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("No vacansiya available"));
        } else {
          List<Ish> ishs = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true, // Ensures ListView doesn't take all space
            physics: NeverScrollableScrollPhysics(),
            itemCount: ishs.length,
            itemBuilder: (context, index) {
              Ish ish = ishs[index];
              return VacanciesCard(
                ish: ish,
              );
            },
          );
        }
      },
    );
  }
}
