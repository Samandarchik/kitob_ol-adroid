import 'package:dio/dio.dart';
import 'package:kitob_ol/core/data/local/token_storage.dart';
import 'package:kitob_ol/core/di/di.dart';
import 'package:kitob_ol/home/model/book_model.dart';

class BookService {
  final TokenStorage tokenStorage = sl<TokenStorage>();
  final Dio dio = sl<Dio>();

  Future<List<BookModel>> fetchBooks(int page) async {
    try {
      final response = await dio.get(
          "https://gateway.axadjonovsardorbek.uz/books/list?status=active&page=$page");

      if (response.statusCode == 200) {
        final data = response.data;

        List<BookModel> books = [];
        for (var bookJson in data['books']) {
          books.add(BookModel.fromJson(bookJson));
        }

        return books;
      } else {
        throw Exception('Kitoblar yuklanmadi!');
      }
    } catch (e) {
      throw Exception('Xatolik yuz berdi: $e');
    }
  }

  Future<void> getBook(String id) async {
    final String url =
        "https://gateway.axadjonovsardorbek.uz/books/get/full?book_id=$id";

    try {
      await dio.get(
        url,
      );
    } catch (e) {}
  }

  Future<void> getVacancy(String id) async {
    final String url =
        "https://gateway.axadjonovsardorbek.uz/vacancies/get?id=$id";

    try {
      await dio.get(
        url,
      );
    } catch (e) {}
  }
}

// double minPrice = 1;
// double maxPrice = 10000;
