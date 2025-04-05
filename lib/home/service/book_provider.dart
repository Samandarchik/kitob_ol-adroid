import 'package:flutter/material.dart';
import 'package:kitob_ol/home/favorite/model.dart';

class BookProvider extends ChangeNotifier {
  List<BookModel> _books = [];
List<BookModel> get books => _books;

  void addBook(BookModel book) {
    _books.add(book);
    notifyListeners();
  }
}