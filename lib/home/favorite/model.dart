class BookModel {
  final String bookId;
  final String sellerName;
  final String sellerEmail;
  final String sellerPhoneNumber;
  final String? sellerImg;
  final String publisherName;
  final String categoryName;
  final String title;
  final String authorName;
  final String language;
  final String description;
  final int totalPages;
  final int price;
  final String imageUrl;
  final String coverType;
  final bool isNew;

  BookModel({
    required this.bookId,
    required this.sellerName,
    required this.sellerEmail,
    required this.sellerPhoneNumber,
    this.sellerImg,
    required this.publisherName,
    required this.categoryName,
    required this.title,
    required this.authorName,
    required this.language,
    required this.description,
    required this.totalPages,
    required this.price,
    required this.imageUrl,
    required this.coverType,
    required this.isNew,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      bookId: json['book_id'] ?? '',
      sellerName: json['seller_name'] ?? '',
      sellerEmail: json['seller_email'] ?? '',
      sellerPhoneNumber: json['seller_phone_number'] ?? '',
      sellerImg: json['seller_img'],
      publisherName: json['publisher_name'] ?? '',
      categoryName: json['category_name'] ?? '',
      title: json['title'] ?? '',
      authorName: json['author_name'] ?? '',
      language: json['language_name'] ?? '',
      description: json['description'] ?? '',
      totalPages: json['total_pages'] ?? 0,
      price: json['price'] ?? 0,
      imageUrl: json['image_url'] ?? '',
      coverType: json['cover_type'] ?? '',
      isNew: json['is_new'] ?? false,
    );
  }
}

class Vacancy {
  final String vacancyId;
  final String publisherName;
  final String vacancyTitle;
  final String vacancyDescription;
  final String status;
  final int salaryFrom;
  final int salaryTo;
  final String workingStyles;
  final String workingTypes;
  final String phoneNumber;

  Vacancy({
    required this.vacancyId,
    required this.publisherName,
    required this.vacancyTitle,
    required this.vacancyDescription,
    required this.status,
    required this.salaryFrom,
    required this.salaryTo,
    required this.workingStyles,
    required this.workingTypes,
    required this.phoneNumber,
  });

  factory Vacancy.fromJson(Map<String, dynamic> json) {
    return Vacancy(
      vacancyId: json['vacancy_id'] ?? '',
      publisherName: json['vacancy_publisher_name'] ?? '',
      vacancyTitle: json['vacancy_title'] ?? '',
      vacancyDescription: json['vacancy_description'] ?? '',
      status: json['status'] ?? '',
      salaryFrom: json['salary_from'] ?? 0,
      salaryTo: json['salary_to'] ?? 0,
      workingStyles: json['working_styles'] ?? '',
      workingTypes: json['working_types'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
    );
  }
}
