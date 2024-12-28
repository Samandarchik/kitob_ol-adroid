import 'package:flutter/material.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/text_style.dart';
import 'package:kitob_ol/vacancies/service/vacancies_service.dart';
import 'package:kitob_ol/vacancies/widgets/vacancies_card.dart';
import 'package:kitob_ol/widget/text_class.dart';

class VacancyListScreen extends StatefulWidget {
  const VacancyListScreen({super.key});

  @override
  State<VacancyListScreen> createState() => _VacancyListScreenState();
}

class _VacancyListScreenState extends State<VacancyListScreen> {
  final VacancyService _vacancyService = VacancyService();
  List<dynamic> _vacancies = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadVacancies();
  }

  Future<void> _loadVacancies() async {
    try {
      final vacancies = await _vacancyService.fetchVacancies();
      setState(() {
        _vacancies = vacancies;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      debugPrint('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vakansiyalar ro\'yxati'),
      ),
      body: _isLoading
          ? ListView.builder(
              itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.all(20),
                    height: 200,
                    width: MediaQuery.of(context).size.width * .8,
                    color: kGreyContainer,
                  ))
          : _vacancies.isEmpty
              ? const Center(child: Text('Vakansiyalar topilmadi.'))
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: _vacancies.length,
                        itemBuilder: (context, index) {
                          final vacancy = _vacancies[index];
                          return VacanciesCard(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VacanciesDetails(
                                            viewCount: vacancy["view_count"],
                                            description: vacancy["description"],
                                            salaryFrom: vacancy['salary_from'],
                                            salaryTo: vacancy['salary_to'],
                                            workingStyles:
                                                vacancy['working_styles'],
                                            workingTypes:
                                                vacancy['working_types'],
                                            vacancie: vacancy['title'],
                                            cityName:
                                                "Joylashuv: ${vacancy['city_name']['uz']}, ${vacancy['district_name']['uz']}",
                                          )));
                            },
                            salaryFrom: vacancy['salary_from'],
                            salaryTo: vacancy['salary_to'],
                            workingStyles: vacancy['working_styles'],
                            workingTypes: vacancy['working_types'],
                            vacancie: vacancy['title'],
                            cityName:
                                "Joylashuv: ${vacancy['city_name']['uz']}, ${vacancy['district_name']['uz']}",
                          );
                        },
                      ),
                    ),
                    Container(width: 100)
                  ],
                ),
    );
  }
}

class VacanciesDetails extends StatelessWidget {
  final String vacancie;
  final int viewCount;
  final String cityName;
  final String workingStyles;
  final String workingTypes;
  final int salaryFrom;
  final int salaryTo;
  final String description;
  const VacanciesDetails(
      {super.key,
      required this.cityName,
      required this.vacancie,
      required this.workingStyles,
      required this.workingTypes,
      required this.salaryFrom,
      required this.viewCount,
      required this.salaryTo,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(vacancie),
      ),
      body: Padding(
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
              "${TextClass().formatNumberWithSpaces(salaryFrom)} ~ ${TextClass().formatNumberWithSpaces(salaryTo)} So'm",
              style: kTSFWB18,
            ),
            myText("Ish turi", workingStyles),
            myText("Mashg'ulot turi", workingTypes),
            myText("Ish tarzi", workingStyles),
            myText("Description", description),
            SizedBox(height: 10),
            Align(
                alignment: Alignment.topRight,
                child: Text("Ko’rilgan: ${viewCount + 1}"))
          ],
        ),
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
