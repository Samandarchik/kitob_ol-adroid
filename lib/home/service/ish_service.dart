import 'package:dio/dio.dart';
import 'package:kitob_ol/core/di/di.dart';
import 'package:kitob_ol/home/service/ish.dart';

class VacancyService {
  final Dio dio = sl<Dio>();
  final String apiUrl = "https://gateway.axadjonovsardorbek.uz/vacancies/list";

  /// Replace with your API URL

  Future<List<Ish>> fetchIshs() async {
    final response = await dio.get(apiUrl);

    if (response.statusCode == 200) {
      final data = response.data["vacancies"];

      // Map the JSON response to Book objects
      List<Ish> ish = [];
      for (var bookJson in data) {
        ish.add(Ish.fromJson(bookJson));
      }
      return ish;
    } else {
      throw Exception('Failed to load books');
    }
  }
}
