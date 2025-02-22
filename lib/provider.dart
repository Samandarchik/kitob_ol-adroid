import 'package:flutter/material.dart';

class FilterProvider extends ChangeNotifier {
  String? _selectedLanguage;
  String? _selectedAuthor;
  String? _selectedCategory;
  String? _selectedPublisher;
  String? _selectedBookStatus;

  // Getterlar
  String? get selectedLanguage => _selectedLanguage;
  String? get selectedAuthor => _selectedAuthor;
  String? get selectedCategory => _selectedCategory;
  String? get selectedPublisher => _selectedPublisher;
  String? get selectedBookStatus => _selectedBookStatus;

  // Setterlar
  void setLanguage(String? language) {
    if (_selectedLanguage != language) {
      _selectedLanguage = language;
      notifyListeners();
    }
  }

  void setAuthor(String? author) {
    if (_selectedAuthor != author) {
      _selectedAuthor = author;
      notifyListeners();
    }
  }

  void setCategory(String? category) {
    if (_selectedCategory != category) {
      _selectedCategory = category;
      notifyListeners();
    }
  }

  void setPublisher(String? publisher) {
    if (_selectedPublisher != publisher) {
      _selectedPublisher = publisher;
      notifyListeners();
    }
  }

  void setBookStatus(String? status) {
    if (_selectedBookStatus != status) {
      _selectedBookStatus = status;
      notifyListeners();
    }
  }

  // Reset qilish funksiyasi (Agar hamma filtrlarni tozalash kerak bo'lsa)
  void resetFilters() {
    _selectedLanguage = null;
    _selectedAuthor = null;
    _selectedCategory = null;
    _selectedPublisher = null;
    _selectedBookStatus = null;
    notifyListeners();
  }
}
