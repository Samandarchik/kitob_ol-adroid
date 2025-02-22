import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kitob_ol/home/model/books_modul.dart';
import 'package:kitob_ol/login/service/token.dart';

class FavouritesService {
  final String apiUrl = "https://gateway.axadjonovsardorbek.uz/favourites/list";
  final bool isRegister = TokenStorage().getToken() == null ? false : true;
  Future<List<BookListFavorite>> fetchBooks() async {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${TokenStorage().token}',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      List<BookListFavorite> books = [];
      for (var bookJson in data['boooks']) {
        books.add(BookListFavorite.fromJson(bookJson));
      }
      return books;
    } else {
      print(response.statusCode);
      return [];
      // throw Exception('Failed to load books');
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
      categoryName: json['category_name'] != null
          ? jsonDecode(json['category_name'])['en']
          : '',
      translatorName: json['translator_name'] ?? '',
      authorName: json['author_name'] ?? '',
      authorSurname: json['author_surname'] ?? '',
      languageName: json['language_name'] != null
          ? jsonDecode(json['language_name'])['en']
          : '',
      title: json['title'] != null ? jsonDecode(json['title'])['en'] : '',
      description: json['description'] ?? '',
      publishedYear: json['published_year'] ?? '',
      totalPages: json['total_pages'] ?? 0,
      price: json['price'] ?? 0,
      stock: json['stock'] ?? 0,
      imageUrl: json['image_url'] ?? '',
      imgUrl: json['img_url'] ?? '',
      writingType: json['writing_type'] ?? '',
      viewCount: json['view_count'] ?? 0,
      cityName:
          json['city_name'] != null ? jsonDecode(json['city_name'])['en'] : '',
      districtName: json['district_name'] ?? '',
      coverType: json['cover_type'] ?? '',
      coverFormat: json['cover_format'] ?? '',
      shitrixCode: json['shitrix_code'] ?? '',
      isNew: json['is_new'] ?? false,
      createdAt: json['created_at'] ?? '',
    );
  }
}
