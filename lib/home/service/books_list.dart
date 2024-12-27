import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kitob_ol/home/modul/books_list.dart';

class BooksList {
  List<PostModel> apiDate = [];

  Future<List<PostModel>> getData(int min, int max) async {
    try {
      final url = Uri.parse("https://gateway.axadjonovsardorbek.uz/books/list");
      final response =
          await http.get(url, headers: {"Content-Type": "application/json"});

      if (response.statusCode == 200) {
        // JSON'dan kelgan ma'lumotni dekodlash
        var data = json.decode(response.body)['books'] as List<dynamic>;

        // Narx oralig'ini filtrlash: min dan max gacha
        apiDate = data.where((item) {
          int price = item["price"];
          return price >= min && price <= max;
        }).map((item) {
          return PostModel(
            description: item["description"],
            publishedYear: item["published_year"],
            id: item["id"],
            sellerId: item["seller_id"],
            publisherId: item["publisher_id"],
            categoryId: item["category_id"],
            translatorId: item["translator_id"],
            authorId: item["author_id"],
            languageId: item["language_id"],
            title: item["title"],
            totalPages: item["total_pages"],
            price: item["price"],
            imageUrl: item["image_url"] ??
                "https://i.pinimg.com/736x/3a/67/19/3a67194f5897030237d83289372cf684.jpg",
            imgUrl: item["img_url"] ??
                "https://i.pinimg.com/736x/3a/67/19/3a67194f5897030237d83289372cf684.jpg",
            writingType: item["writing_type"],
            viewCount: item["view_count"] ?? 0,
            location: {
              "city_id": item["location"]["city_id"],
              "district_id": item["location"]["district_id"]
            },
            coverType: item["cover_type"],
            coverFormat: item["cover_format"],
            shitrixCode: item["shitrix_code"],
            createdAt: item["created_at"],
            isNew: item.containsKey("is_new") ? item["is_new"] : null,
          );
        }).toList();
      } else {
        print('API xatosi: ${response.statusCode}');
      }
    } catch (e) {
      print('Xatolik: $e');
    }
    return apiDate;
  }
}
