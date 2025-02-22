import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kitob_ol/home/model/books_modul.dart';
import 'package:kitob_ol/login/service/token.dart';

class BookService {
  final String apiUrl =
      "https://gateway.axadjonovsardorbek.uz/books/list?status=active";

  /// Replace with your API URL

  Future<List<Book>> fetchBooks() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      minPrice = data["min_price"];
      maxPrice = data["max_price"];
      // Map the JSON response to Book objects

      List<Book> books = [];
      for (var bookJson in data['books']) {
        books.add(Book.fromJson(bookJson));
      }
      return books;
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<String> getBook(String id) async {
    final String url =
        "https://gateway.axadjonovsardorbek.uz/books/get/full?book_id=$id";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data['view_count'].toString();
    } else {
      throw Exception('Failed to load books');
    }
  }
}

num minPrice = 1;
num maxPrice = 10000;
