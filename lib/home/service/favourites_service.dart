import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kitob_ol/home/model/favourite_model.dart';

// Book Service
class BookService {
  final String apiUrl = "https://example.com/books";

  Future<List<BookModel>> fetchBooks() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((book) => BookModel.fromJson(book)).toList();
    } else {
      throw Exception("Failed to load books");
    }
  }
}

// Vacancy Service
class VacancyService {
  final String apiUrl = "https://example.com/vacancies";

  Future<List<VacancyModel>> fetchVacancies() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((vacancy) => VacancyModel.fromJson(vacancy)).toList();
    } else {
      throw Exception("Failed to load vacancies");
    }
  }
}
