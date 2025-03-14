import 'dart:convert';

import 'package:kitob_ol/home/model/favourite_model.dart';
import 'package:kitob_ol/provider_auth.dart';
import 'package:http/http.dart' as http;

class BookService {
  final String apiUrl =
      "https://gateway.axadjonovsardorbek.uz/books/list?status=active";

  Future<List<BookModel>> fetchBooks() async {
    String token = await AuthProvider().getToken();

    try {
      final response = await _sendRequestWithToken(apiUrl, token);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        minPrice = data["min_price"];
        maxPrice = data["max_price"];

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

  Future<String> getBook(String id) async {
    String token = await AuthProvider().getToken();
    final String url =
        "https://gateway.axadjonovsardorbek.uz/books/get/full?book_id=$id";

    try {
      final response = await _sendRequestWithToken(url, token);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['view_count'].toString();
      } else {
        throw Exception('Kitob yuklanmadi!');
      }
    } catch (e) {
      throw Exception('Xatolik yuz berdi: $e');
    }
  }

  // Tokenni avtomatik yangilab so‘rov yuborish funksiyasi

  Future<http.Response> _sendRequestWithToken(String url, String token) async {
    final response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $token'},
    );

    // Agar token eskirgan bo'lsa, yangi token olib qayta so'rov yuboramiz
    if (response.statusCode == 401) {
      final newToken = await AuthProvider().updateToken();
      return http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $newToken'},
      );
    }

    return response;
  }
}

num minPrice = 1;
num maxPrice = 10000;
