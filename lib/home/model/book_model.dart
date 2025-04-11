class BookModel {
  final String id;
  final String? sellerName;
  final String? sellerEmail;
  final String? sellerPhoneNumber;
  final String? sellerImg;
  final String publisherName;
  final Map<String, dynamic> categoryName;
  final String translatorName;
  final String translatorSurname;
  final String authorName;
  final String authorSurname;
  final Map<String, dynamic> languageName;
  final String title;
  final String description;
  final String publishedYear;
  final int totalPages;
  final int price;
  final int stock;
  final String imageUrl;
  final Map<String, dynamic> districtName;
  final String imgUrl;
  final String writingType;
  final int viewCount;
  final Map<String, dynamic> cityName;
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
      required this.cityName,
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
      categoryName: json['category_name'] ?? '',
      translatorName: json['translator_name'] ?? '',
      translatorSurname: json['translator_surname'] ?? '',
      authorName: json['author_name'] ?? '',
      authorSurname: json['author_surname'] ?? '',
      languageName: json['language_name'] ?? '',
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
      cityName: json['city_name'] ?? '',
      imgUrl: json['img_url'] ?? '',
      imageUrl: json['image_url'] ?? '',
      isFavourite: json['is_favorite'] ?? false,
      districtName: json['district_name'] ?? '',
    );
  }
}

// // Vacancy Model
// class VacancyModel {
//   final String? id;
//   final String? position;
//   final String? companyName;
//   final String? city_name;
//   final int? salary;
//   final String? description;

//   VacancyModel({
//     this.id,
//     this.position,
//     this.companyName,
//     this.location,
//     this.salary,
//     this.description,
//   });

//   factory VacancyModel.fromJson(Map<String, dynamic> json) {
//     return VacancyModel(
//       id: json['id'] ?? '',
//       position: json['position'] ?? '',
//       companyName: json['company_name'] ?? '',
//       location: json['location'] ?? '',
//       salary: json['salary'] ?? 0,
//       description: json['description'] ?? '',
//     );
//   }
// }
