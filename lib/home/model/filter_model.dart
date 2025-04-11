class FilterModel {
  String? categoryId;
  String? translatorId;
  String? languageId;
  int? priceFrom;
  int? priceTo;
  String? selectedPublisher;
  String? selectedLanguage;
  String? selectedCategory;
  String? selectedAuthor;

  FilterModel({
    this.categoryId,
    this.translatorId,
    this.languageId,
    this.priceFrom,
    this.priceTo,
    this.selectedPublisher,
    this.selectedLanguage,
    this.selectedCategory,
    this.selectedAuthor,
  });
}
