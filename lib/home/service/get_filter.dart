import 'dart:convert';
import 'package:http/http.dart' as http;

class GetFilter extends FilerData {
  Future<void> fetchFilteredBooks({
    String? categoryId,
    String? translatorId,
    String? languageId,
    int? priceFrom,
    int? priceTo,
  }) async {
    final Uri uri = Uri.https(
      "gateway.axadjonovsardorbek.uz",
      "/books/list",
      {
        if (categoryId != null) "category_id": categoryId,
        if (translatorId != null) "translator_id": translatorId,
        if (languageId != null) "language_id": languageId,
        if (priceFrom != null) "price_from": priceFrom.toString(),
        if (priceTo != null) "price_to": priceTo.toString(),
        "status": "active",
      },
    );

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        print(uri);
        var data = json.decode(response.body);
        print("Natija: $data");
      } else {
        print("Xatolik: ${response.statusCode}");
      }
    } catch (e) {
      print("Xatolik yuz berdi: $e");
    }
  }

// Chaqarish usuli:
// fetchFilteredBooks(
//   categoryId: "6ada6127-42c7-4fde-8f84-6d5e52a4b43c",
//   translatorId: "d4b591c9-d0dc-4d2f-93f9-c2e2002daa6a",
//   languageId: "500ca009-6f32-44d6-8aca-5f5a993ed5be",
//   priceFrom: 75000,
//   priceTo: 900000,
// );
}

class FilerData {
  String? categoryId;
  String? translatorId;
  String? languageId;
  int? priceFrom;
  int? priceTo;
  String? selectedPublisher;
  String? selectedLanguage;
  String? selectedCategory;
  String? selectedAuthor;
}
