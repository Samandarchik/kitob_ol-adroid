class Book {
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

  Book({
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
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] ?? "",
      sellerName: json['seller_name'] ?? "",
      sellerEmail: json['seller_email'] ?? "",
      sellerPhoneNumber: json['seller_phone_number'] ?? "",
      sellerImg: json['seller_img'] ?? "",
      publisherName: json['publisher_name'] ?? "",
      categoryName: json['category_name']['en'] ?? "",
      translatorName: json['translator_name'] ?? "",
      authorName: json['author_name'] ?? "",
      authorSurname: json['author_surname'] ?? "",
      languageName: json['language_name']['en'] ?? "",
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      publishedYear: json['published_year'] ?? "",
      totalPages: json['total_pages'] ?? "",
      price: json['price'] ?? "",
      stock: json['stock'] ?? "",
      imageUrl: json['image_url'] ?? "",
      imgUrl: json['img_url'] ?? "",
      writingType: json['writing_type'] ?? "",
      viewCount: json['view_count'] ?? "",
      cityName: json['city_name']['en'] ?? "",
      districtName: json['district_name']['en'] ?? "",
      coverType: json['cover_type'] ?? "",
      coverFormat: json['cover_format'] ?? "",
      shitrixCode: json['shitrix_code'] ?? "",
      isNew: json['is_new'] ?? "",
      createdAt: json['created_at'] ?? "",
    );
  }
}
