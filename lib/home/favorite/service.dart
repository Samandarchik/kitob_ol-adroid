import 'package:dio/dio.dart';
import 'package:kitob_ol/home/model/favourite_model.dart';

class FavouritesService {
  final Dio _dio = Dio();
  final String apiUrl = "https://gateway.axadjonovsardorbek.uz/favourites/list";

  Future<List<BookModel>> fetchBooks(String token) async {
    try {
      final response = await _dio.get(
        apiUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        List<BookModel> books = [];

        for (var item in data['boooks']) {
          if (item['book_id'] != "undefined") {
            books.add(BookModel.fromJson(item));
          }
        }
        return books;
      } else {
        throw Exception('Failed to load books');
      }
    } catch (e) {
      print('Error fetching books: $e');
      return [];
    }
  }

  Future<List<VacancyModel>> fetchVacancies(String token) async {
    try {
      final response = await _dio.get(
        apiUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        List<VacancyModel> vacancies = [];

        for (var item in data['boooks']) {
          if (item['vacancy_id'] != "undefined") {
            vacancies.add(VacancyModel.fromJson(item));
          }
        }
        return vacancies;
      } else {
        throw Exception('Failed to load vacancies');
      }
    } catch (e) {
      print('Error fetching vacancies: $e');
      return [];
    }
  }
}
