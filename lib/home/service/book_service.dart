import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kitob_ol/home/modul/books_list.dart';

class BookService {
  final String apiUrl =
      "https://gateway.axadjonovsardorbek.uz/books/list"; // Replace with your API URL

  Future<List<Book>> fetchBooks() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

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
}
