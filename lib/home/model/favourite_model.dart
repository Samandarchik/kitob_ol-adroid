class BookModel {
  final String id;
  final String? sellerName;
  final String? sellerEmail;
  final String? sellerPhoneNumber;
  final String? sellerImg;
  final String publisherName;
  final CategoryName categoryName;
  final String translatorName;
  final String translatorSurname;
  final String authorName;
  final String authorSurname;
  final LanguageName languageName;
  final String title;
  final String description;
  final String publishedYear;
  final int totalPages;
  final int price;
  final int stock;
  final String imageUrl;
  final DistrictName districtName;
  final String imgUrl;
  final String writingType;
  final int viewCount;
  final CityName location;
  final String shitrixCode;
  final String coverType;
  final bool isNew;
  final String coverFormat;
  bool isFavourite;

  BookModel(
      {required this.id,
      this.sellerName,
      this.sellerEmail,
      this.sellerPhoneNumber,
      this.sellerImg,
      required this.imgUrl,
      required this.imageUrl,
      required this.publisherName,
      required this.categoryName,
      required this.translatorName,
      required this.translatorSurname,
      required this.authorName,
      required this.authorSurname,
      required this.languageName,
      required this.title,
      required this.description,
      required this.shitrixCode,
      required this.coverType,
      required this.totalPages,
      required this.isNew,
      required this.coverFormat,
      required this.writingType,
      required this.publishedYear,
      required this.price,
      required this.stock,
      required this.viewCount,
      required this.location,
      required this.districtName,
      this.isFavourite = false});

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'] ?? '',
      sellerName: json['seller_name'] ?? '',
      sellerEmail: json['seller_email'] ?? '',
      sellerPhoneNumber: json['seller_phone_number'] ?? '',
      sellerImg: json['seller_img'] ?? '',
      publisherName: json['publisher_name'] ?? '',
      categoryName: CategoryName.fromJson(json['category_name']),
      translatorName: json['translator_name'] ?? '',
      translatorSurname: json['translator_surname'] ?? '',
      authorName: json['author_name'] ?? '',
      authorSurname: json['author_surname'] ?? '',
      languageName: LanguageName.fromJson(json['language_name']),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      shitrixCode: json['shitrix_code'] ?? '',
      coverType: json['coverType'] ?? '',
      totalPages: json['total_pages'] ?? 0,
      isNew: json['isNew'] ?? false,
      coverFormat: json['cover_format'] ?? '',
      writingType: json['writing_type'] ?? '',
      publishedYear: json['published_year'] ?? "0",
      price: json['price'] ?? 0,
      stock: json['stock'] ?? 0,
      viewCount: json['view_count'] ?? 0,
      location: CityName.fromJson(json['city_name']),
      imgUrl: json['img_url'] ?? '',
      imageUrl: json['image_url'] ?? '',
      isFavourite: json['is_favorite'] ?? false,
      districtName: DistrictName.fromJson(json['district_name']),
    );
  }
}

class CategoryName {
  final String en;
  final String ru;
  final String uz;

  CategoryName({
    required this.en,
    required this.ru,
    required this.uz,
  });

  factory CategoryName.fromJson(Map<String, dynamic> json) {
    return CategoryName(
      en: json['en'] ?? '',
      ru: json['ru'] ?? '',
      uz: json['uz'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'en': en,
      'ru': ru,
      'uz': uz,
    };
  }
}

class LanguageName {
  final String en;
  final String ru;
  final String uz;

  LanguageName({
    required this.en,
    required this.ru,
    required this.uz,
  });

  factory LanguageName.fromJson(Map<String, dynamic> json) {
    return LanguageName(
      en: json['en'] ?? '',
      ru: json['ru'] ?? '',
      uz: json['uz'] ?? '',
    );
  }
}

class CityName {
  final String en;
  final String ru;
  final String uz;

  CityName({
    required this.en,
    required this.ru,
    required this.uz,
  });

  factory CityName.fromJson(Map<String, dynamic> json) {
    return CityName(
      en: json['en'] ?? '',
      ru: json['ru'] ?? '',
      uz: json['uz'] ?? '',
    );
  }
}

class DistrictName {
  final String en;
  final String ru;
  final String uz;

  DistrictName({
    required this.en,
    required this.ru,
    required this.uz,
  });

  factory DistrictName.fromJson(Map<String, dynamic> json) {
    return DistrictName(
      en: json['en'] ?? '',
      ru: json['ru'] ?? '',
      uz: json['uz'] ?? '',
    );
  }
}

// Vacancy Model
class VacancyModel {
  final String? id;
  final String? position;
  final String? companyName;
  final String? location;
  final int? salary;
  final String? description;

  VacancyModel({
    this.id,
    this.position,
    this.companyName,
    this.location,
    this.salary,
    this.description,
  });

  factory VacancyModel.fromJson(Map<String, dynamic> json) {
    return VacancyModel(
      id: json['id'] ?? '',
      position: json['position'] ?? '',
      companyName: json['company_name'] ?? '',
      location: json['location'] ?? '',
      salary: json['salary'] ?? 0,
      description: json['description'] ?? '',
    );
  }
}
