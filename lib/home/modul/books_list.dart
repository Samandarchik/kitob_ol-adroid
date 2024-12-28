class Book {
  final String id;
  final String sellerName;
  final String sellerEmail;
  final String sellerPhoneNumber;
  final String sellerImg;
  final String publisherName;
  final String categoryName;
  final String translatorName;
  final String authorName;
  final String authorSurname;
  final String languageName;
  final String title;
  final String description;
  final String publishedYear;
  final int totalPages;
  final int price;
  final int stock;
  final String imageUrl;
  final String imgUrl;
  final String writingType;
  final int viewCount;
  final String cityName;
  final String districtName;
  final String coverType;
  final String coverFormat;
  final String shitrixCode;
  final bool isNew;
  final String createdAt;

  Book({
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

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      sellerName: json['seller_name'],
      sellerEmail: json['seller_email'],
      sellerPhoneNumber: json['seller_phone_number'],
      sellerImg: json['seller_img'],
      publisherName: json['publisher_name'],
      categoryName: json['category_name']['en'],
      translatorName: json['translator_name'],
      authorName: json['author_name'],
      authorSurname: json['author_surname'],
      languageName: json['language_name']['en'],
      title: json['title'],
      description: json['description'],
      publishedYear: json['published_year'],
      totalPages: json['total_pages'],
      price: json['price'],
      stock: json['stock'],
      imageUrl: json['image_url'],
      imgUrl: json['img_url'],
      writingType: json['writing_type'],
      viewCount: json['view_count'],
      cityName: json['city_name']['en'],
      districtName: json['district_name']['en'],
      coverType: json['cover_type'],
      coverFormat: json['cover_format'],
      shitrixCode: json['shitrix_code'],
      isNew: json['is_new'],
      createdAt: json['created_at'],
    );
  }
}
