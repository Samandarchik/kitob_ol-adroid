import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kitob_ol/home/model/category_model.dart';

class ApiService {
  static const String baseUrl = "https://gateway.axadjonovsardorbek.uz";

  static Future<List<Language>> fetchLanguages() async {
    final response = await http.get(Uri.parse("$baseUrl/languages/list"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data["languages"]["languages"] as List)
          .map((json) => Language.fromJson(json))
          .toList();
    } else {
      throw Exception("Languages yuklab bo'lmadi!");
    }
  }

  static Future<List<Author>> fetchAuthors() async {
    final response = await http.get(Uri.parse("$baseUrl/authors/list"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data["authors"] as List)
          .map((json) => Author.fromJson(json))
          .toList();
    } else {
      throw Exception("Mualliflar yuklab bo'lmadi!");
    }
  }

  static Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse("$baseUrl/categories/list"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data["Categories"]["categories"] as List)
          .map((json) => Category.fromJson(json))
          .toList();
    } else {
      throw Exception("Kategoriyalar yuklab bo'lmadi!");
    }
  }

  static Future<List<Publisher>> fetchPublishers() async {
    final response = await http.get(Uri.parse("$baseUrl/publishers/list"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data["publishers"] as List)
          .map((json) => Publisher.fromJson(json))
          .toList();
    } else {
      throw Exception("Nashriyotlar yuklab bo'lmadi!");
    }
  }
}

class AppData {
  static List<Language> languages = [];
  static List<Author> authors = [];
  static List<Category> categories = [];
  static List<Publisher> publishers = [];

  static Future<void> loadAllData() async {
    try {
      languages = await ApiService.fetchLanguages();
      authors = await ApiService.fetchAuthors();
      categories = await ApiService.fetchCategories();
      publishers = await ApiService.fetchPublishers();
    } catch (e) {
      print("Xatolik: $e");
    }
  }
}
