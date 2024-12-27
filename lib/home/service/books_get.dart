import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kitob_ol/home/modul/books_list.dart';
import 'package:kitob_ol/home/service/book_detail.dart';

class BookGet {
// https://gateway.axadjonovsardorbek.uz/books/get?book_id=b68e0e62-1c71-4637-ab18-718e3c99b19b

  List<PostModel> apiDate = [];

  Future<List<PostModel>> getData(String id) async {
    try {
      final url = Uri.parse(
          "https://gateway.axadjonovsardorbek.uz/books/get?book_id=$id");
      final response =
          await http.get(url, headers: {"Content-Type": "application/json"});

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        for (final item in data) {
          apiDate.add(PostModel(
              description: item["description"],
              publishedYear: item["published_year"],
              id: item["id"],
              sellerId: item["user_id"],
              publisherId: item["publisher_id"],
              categoryId: item["category_id"],
              translatorId: item["translator_id"],
              authorId: item["author_id"],
              languageId: item["language_id"],
              title: item["title"],
              totalPages: item["total_pages"],
              price: item["price"],
              imageUrl: item["image_url"],
              writingType: item["writing_type"],
              viewCount: int.tryParse(item["viewCount"].toString()) ?? 0,
              location: item["location"] ?? [],
              imgUrl: item["img_url"],
              coverType: item["cover_type"],
              coverFormat: item["cover_format"],
              shitrixCode: item["shitrix_code"],
              createdAt: item["created_at"]));
        }
      } else {
        print('API xatosi: ${response.statusCode}');
      }
    } catch (e) {
      print('Xatolik: $e');
    }
    return apiDate;
  }
}
