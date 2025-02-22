import 'dart:convert';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class ImageUpload {
  String? imageLink;
  Future<void> addBook() async {
    return;
  }

  Future<File?> _compressImage(File imageFile) async {
    final dir = await getTemporaryDirectory();
    final targetPath = '${dir.path}/${basename(imageFile.path)}.jpg';

    var result = await FlutterImageCompress.compressAndGetFile(
      imageFile.absolute.path,
      targetPath,
      quality: 85,
    );

    return result != null ? File(result.path) : null;
  }

  Future uploadImage(File? _image) async {
    if (_image == null) return;

    // Rasm hajmini tekshirish
    int fileSize = await _image.length();
    print("Original image size: ${fileSize / (1024 * 1024)} MB");

    // Agar 2MB dan katta bo‘lsa, siqish
    if (fileSize > 2 * 1024 * 1024) {
      print("Compressing image...");
      _image = await _compressImage(_image);
    }

    // Siqilgan rasm hajmini qayta tekshirish
    if (_image == null) return;
    int newSize = await _image.length();
    print("Compressed image size: ${newSize / (1024 * 1024)} MB");

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://gateway.axadjonovsardorbek.uz/img-upload'),
    );

    request.headers.addAll({
      'Accept': 'application/json',
      'Content-Type': 'multipart/form-data',
    });

    var file = await http.MultipartFile.fromPath(
      'file',
      _image.path,
      contentType: MediaType('image', 'jpeg'),
    );

    request.files.add(file);

    var response = await request.send();
    var responseBody = await response.stream.bytesToString();

    print("Status: ${response.statusCode}");
    print("Response: $responseBody");

    if (response.statusCode == 200) {
      imageLink = responseBody; // JSON formatda bo'lsa, decode qilish kerak
    }
  }
}

class Book {
  final String authorId;
  final String categoryId;
  final String coverFormat;
  final String coverType;
  final String description;
  final String imageUrl;
  final String imgUrl;
  final bool isNew;
  final String languageId;
  final Location location;
  final int price;
  final String publishedYear;
  final String publisherId;
  final String sellerId;
  final String shitrixCode;
  final int stock;
  final String title;
  final int totalPages;
  final String translatorId;
  final String writingType;

  Book({
    required this.authorId,
    required this.categoryId,
    required this.coverFormat,
    required this.coverType,
    required this.description,
    required this.imageUrl,
    required this.imgUrl,
    required this.isNew,
    required this.languageId,
    required this.location,
    required this.price,
    required this.publishedYear,
    required this.publisherId,
    required this.sellerId,
    required this.shitrixCode,
    required this.stock,
    required this.title,
    required this.totalPages,
    required this.translatorId,
    required this.writingType,
  });

  Map<String, dynamic> toJson() {
    return {
      'author_id': authorId,
      'category_id': categoryId,
      'cover_format': coverFormat,
      'cover_type': coverType,
      'description': description,
      'image_url': imageUrl,
      'img_url': imgUrl,
      'is_new': isNew,
      'language_id': languageId,
      'location': location.toJson(),
      'price': price,
      'published_year': publishedYear,
      'publisher_id': publisherId,
      'seller_id': sellerId,
      'shitrix_code': shitrixCode,
      'stock': stock,
      'title': title,
      'total_pages': totalPages,
      'translator_id': translatorId,
      'writing_type': writingType,
    };
  }
}

class Location {
  final String cityId;
  final String districtId;

  Location({
    required this.cityId,
    required this.districtId,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      cityId: json['city_id'],
      districtId: json['district_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city_id': cityId,
      'district_id': districtId,
    };
  }
}

// `Book` obyektini JSON stringga aylantirish
String bookToJson(Book data) => json.encode(data.toJson());
