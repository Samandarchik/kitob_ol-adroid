// Book
class BookModel {
  final String? id;
  final String? sellerName;
  final String? sellerEmail;
  final String? sellerPhoneNumber;
  final String? sellerImg;
  final String? publisherName;
  final Map<String, String>? categoryName;
  final String? translatorName;
  final String? translatorSurname;
  final String? authorName;
  final String? authorSurname;
  final Map<String, String>? languageName;
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
  final Map<String, String>? cityName;
  final Map<String, String>? districtName;
  final String? coverType;
  final String? coverFormat;
  final String? shitrixCode;
  final bool? isNew;
  final String? createdAt;
  bool? isFavorite;

  BookModel({
    this.id,
    this.sellerName,
    this.sellerEmail,
    this.sellerPhoneNumber,
    this.sellerImg,
    this.publisherName,
    this.categoryName,
    this.translatorName,
    this.translatorSurname,
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

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'] ?? '',
      sellerName: json['seller_name'] ?? '',
      sellerEmail: json['seller_email'] ?? '',
      sellerPhoneNumber: json['seller_phone_number'] ?? '',
      sellerImg: json['seller_img'] ?? '',
      publisherName: json['publisher_name'] ?? '',
      categoryName: json['category_name'] != null
          ? Map<String, String>.from(json['category_name'])
          : {},
      translatorName: json['translator_name'] ?? '',
      translatorSurname: json['translator_surname'] ?? '',
      authorName: json['author_name'] ?? '',
      authorSurname: json['author_surname'] ?? '',
      languageName: json['language_name'] != null
          ? Map<String, String>.from(json['language_name'])
          : {},
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      publishedYear: json['published_year'] ?? '',
      totalPages: json['total_pages'] ?? 0,
      price: json['price'] ?? 0,
      stock: json['stock'] ?? 0,
      imageUrl: json['image_url'] ?? '',
      imgUrl: json['img_url'] ?? '',
      writingType: json['writing_type'] ?? '',
      viewCount: json['view_count'] ?? 0,
      cityName: json['city_name'] != null
          ? Map<String, String>.from(json['city_name'])
          : {},
      districtName: json['district_name'] != null
          ? Map<String, String>.from(json['district_name'])
          : {},
      coverType: json['cover_type'] ?? '',
      coverFormat: json['cover_format'] ?? '',
      shitrixCode: json['shitrix_code'] ?? '',
      isNew: json['is_new'] ?? false,
      createdAt: json['created_at'] ?? '',
      isFavorite: json['is_favorite'] ?? '',
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
