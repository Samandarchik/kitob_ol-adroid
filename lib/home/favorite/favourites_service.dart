import 'package:dio/dio.dart';
import 'package:kitob_ol/core/di/di.dart';

class FavouritesService {
  final Dio _dio = sl<Dio>(); // Dio ni dependency injection orqali olish

  // Sevimlilar ro'yxatini olish metodi
  Future<List<BookListFavorite>> fetchFavorite(String token) async {
    try {
      print("Token Get: $token");

      final response = await _dio.get(
        'https://auth.axadjonovsardorbek.uz/auth/profile',
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );

      print("Status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        // JSON massivi kelgan deb taxmin qilib, uni listga aylantiramiz
        List<dynamic> data = response.data['boook'] ?? [];
        return data.map((e) => BookListFavorite.fromJson(e)).toList();
      }

      throw Exception('⚠️ Xatolik: Status code ${response.statusCode}');
    } catch (e) {
      print("❌ Xatolik: $e");
      throw Exception("Tizimda xatolik: $e");
    }
  }
}

class BookListFavorite {
  final String? id;
  final String? sellerName;
  final String? sellerEmail;
  final String? sellerPhoneNumber;
  final String? sellerImg;
  final String? publisherName;
  final String? categoryName;
  final String? translatorName;
  final String? authorName;
  final String? authorSurname;
  final String? languageName;
  final String? title;
  final String? description;
  final String? publishedYear;
  final int? totalPages;
  final int? price;
  final int? stock;
  final String? imageUrl;
  final String? imgUrl;
  final String? writingType;
  final int? viewCount;
  final String? cityName;
  final String? districtName;
  final String? coverType;
  final String? coverFormat;
  final String? shitrixCode;
  final bool? isNew;
  final String? createdAt;

  BookListFavorite({
    required this.id,
    required this.sellerName,
    required this.sellerEmail,
    required this.sellerPhoneNumber,
    required this.sellerImg,
    required this.publisherName,
    required this.categoryName,
    required this.translatorName,
    required this.authorName,
    required this.authorSurname,
    required this.languageName,
    required this.title,
    required this.description,
    required this.publishedYear,
    required this.totalPages,
    required this.price,
    required this.stock,
    required this.imageUrl,
    required this.imgUrl,
    required this.writingType,
    required this.viewCount,
    required this.cityName,
    required this.districtName,
    required this.coverType,
    required this.coverFormat,
    required this.shitrixCode,
    required this.isNew,
    required this.createdAt,
  });

  factory BookListFavorite.fromJson(Map<String, dynamic> json) {
    return BookListFavorite(
      id: json['id'] ?? '',
      sellerName: json['seller_name'] ?? '',
      sellerEmail: json['seller_email'] ?? '',
      sellerPhoneNumber: json['seller_phone_number'] ?? '',
      sellerImg: json['seller_img'] ?? '',
      publisherName: json['publisher_name'] ?? '',
      categoryName:
          json['category_name'] != null ? (json['category_name'])['en'] : '',
      translatorName: json['translator_name'] ?? '',
      authorName: json['author_name'] ?? '',
      authorSurname: json['author_surname'] ?? '',
      languageName:
          json['language_name'] != null ? (json['language_name'])['en'] : '',
      title: json['title'] != null ? (json['title'])['en'] : '',
      description: json['description'] ?? '',
      publishedYear: json['published_year'] ?? '',
      totalPages: json['total_pages'] ?? 0,
      price: json['price'] ?? 0,
      stock: json['stock'] ?? 0,
      imageUrl: json['image_url'] ?? '',
      imgUrl: json['img_url'] ?? '',
      writingType: json['writing_type'] ?? '',
      viewCount: json['view_count'] ?? 0,
      cityName: json['city_name'] != null ? (json['city_name'])['en'] : '',
      districtName: json['district_name'] ?? '',
      coverType: json['cover_type'] ?? '',
      coverFormat: json['cover_format'] ?? '',
      shitrixCode: json['shitrix_code'] ?? '',
      isNew: json['is_new'] ?? false,
      createdAt: json['created_at'] ?? '',
    );
  }
}
