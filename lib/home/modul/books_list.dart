class PostModel {
  String id;
  String sellerId;
  String publisherId;
  String categoryId;
  String translatorId;
  String authorId;
  String languageId;
  String title;
  int totalPages;
  int price;
  String imageUrl;
  String imgUrl;
  String writingType;
  int viewCount;
  String description;
  Map<String, String> location; // location endi Map bo'ldi
  String coverType;
  String coverFormat;
  String shitrixCode;
  String createdAt;
  String publishedYear;
  bool? isNew; // is_new nullable bo'lishi mumkin
  PostModel(
      {required this.publishedYear,
      required this.id,
      required this.sellerId,
      required this.publisherId,
      required this.categoryId,
      required this.translatorId,
      required this.authorId,
      required this.languageId,
      required this.title,
      required this.totalPages,
      required this.price,
      required this.imageUrl,
      required this.imgUrl,
      required this.writingType,
      required this.viewCount,
      required this.location,
      required this.coverType,
      required this.coverFormat,
      required this.shitrixCode,
      required this.createdAt,
      this.isNew,
      required this.description});
}
