import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BookModelFavorite {
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
  final bool? isFavorite;

  BookModelFavorite({
    this.id,
    this.sellerName,
    this.sellerEmail,
    this.sellerPhoneNumber,
    this.sellerImg,
    this.publisherName,
    this.categoryName,
    this.translatorName,
    this.authorName,
    this.authorSurname,
    this.languageName,
    this.title,
    this.description,
    this.publishedYear,
    this.totalPages,
    this.price,
    this.stock,
    this.imageUrl,
    this.imgUrl,
    this.writingType,
    this.viewCount,
    this.cityName,
    this.districtName,
    this.coverType,
    this.coverFormat,
    this.shitrixCode,
    this.isNew,
    this.createdAt,
    this.isFavorite,
  });

  factory BookModelFavorite.fromJson(
      Map<String, dynamic> json, BuildContext contex) {
    return BookModelFavorite(
      id: json['id'] ?? "",
      sellerName: json['seller_name'] ?? "",
      sellerEmail: json['seller_email'] ?? "",
      sellerPhoneNumber: json['seller_phone_number'] ?? "",
      sellerImg: json['seller_img'] ?? "",
      publisherName: json['publisher_name'] ?? "",
      categoryName: _parseJsonField(json, 'category_name', contex),
      translatorName: json['translator_name'] ?? "",
      authorName: json['author_name'] ?? "",
      authorSurname: json['author_surname'] ?? "",
      languageName: _parseJsonField(json, 'language_name', contex),
      title: _parseJsonField(json, 'title', contex),
      description: json['description'] ?? "",
      publishedYear: json['published_year'] ?? "",
      totalPages: int.tryParse(json['total_pages'].toString()) ?? 0,
      price: int.tryParse(json['price'].toString()) ?? 0,
      stock: int.tryParse(json['stock'].toString()) ?? 0,
      imageUrl: json['image_url'] ?? "",
      imgUrl: json['img_url'] ?? "",
      writingType: json['writing_type'] ?? "",
      viewCount: int.tryParse(json['view_count'].toString()) ?? 0,
      cityName: _parseJsonField(json, 'city_name', contex),
      districtName: json['district_name'] ?? "",
      coverType: json['cover_type'] ?? "",
      coverFormat: json['cover_format'] ?? "",
      shitrixCode: json['shitrix_code'] ?? "",
      isNew: json['is_new'] ?? false,
      createdAt: json['created_at'] ?? "",
      isFavorite: json['is_favorite'] ?? false,
    );
  }

  /// JSON ichidagi string bo'lgan obyektlarni mapga o‘girish
  static String _parseJsonField(
      Map<String, dynamic> json, String key, BuildContext contex) {
    try {
      return json.containsKey(key)
          ? jsonDecode(json[key])[contex.locale.languageCode] ?? ""
          : "";
    } catch (e) {
      return "";
    }
  }
}
