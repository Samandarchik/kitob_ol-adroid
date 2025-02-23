// Book Model
class BookModel {
  final String? id;
  final String? title;
  final String? authorName;
  final String? publisherName;
  final String? categoryName;
  final String? languageName;
  final int? price;
  final String? imageUrl;
  final bool? isNew;

  BookModel({
    this.id,
    this.title,
    this.authorName,
    this.publisherName,
    this.categoryName,
    this.languageName,
    this.price,
    this.imageUrl,
    this.isNew,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      authorName: json['author_name'] ?? '',
      publisherName: json['publisher_name'] ?? '',
      categoryName: json['category_name'] ?? '',
      languageName: json['language_name'] ?? '',
      price: json['price'] ?? 0,
      imageUrl: json['image_url'] ?? '',
      isNew: json['is_new'] ?? false,
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
