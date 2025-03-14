import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kitob_ol/home/model/favourite_model.dart';

class GetFilter extends FilterModel {
  Future<List<BookModel>?> fetchFilteredBooks(
    FilterModel filterModel,
  ) async {
    final Uri uri = Uri.https(
      "gateway.axadjonovsardorbek.uz",
      "/books/list",
      {
        if (filterModel.categoryId != null)
          "category_id": filterModel.categoryId,
        if (filterModel.translatorId != null)
          "translator_id": filterModel.translatorId,
        if (filterModel.languageId != null)
          "language_id": filterModel.languageId,
        if (filterModel.priceFrom != null)
          "price_from": filterModel.priceFrom.toString(),
        if (filterModel.priceTo != null)
          "price_to": filterModel.priceTo.toString(),
        "status": "active",
      },
    );

    try {
      print(
          "Filter: priceTo ${filterModel.priceTo}, priceFrom ${filterModel.priceFrom}");
      print("Request URI: $uri");

      final response = await http.get(uri);
      print("Status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['books'] != null &&
            data['books'] is List &&
            data['books'].isNotEmpty) {
          List<dynamic> books = data['books'];
          return books.map((book) => BookModel.fromJson(book)).toList();
        } else {
          print("Ma'lumotlar topilmadi");
          return [];
        }
      } else {
        throw Exception("Server xatosi: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Tizimda xatolik yuz berdi: $e");
    }
  }
}

class FilterModel {
  String? categoryId;
  String? translatorId;
  String? languageId;
  int? priceFrom;
  int? priceTo;
  String? selectedPublisher;
  String? selectedLanguage;
  String? selectedCategory;
  String? selectedAuthor;

  FilterModel({
    this.categoryId,
    this.translatorId,
    this.languageId,
    this.priceFrom,
    this.priceTo,
    this.selectedPublisher,
    this.selectedLanguage,
    this.selectedCategory,
    this.selectedAuthor,
  });
}
