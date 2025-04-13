class FilterModel {
  final String? categoryId;
  final String? translatorId;
  final String? languageId;
  final String? publisherId;
  final bool? isNew;
  final int? priceFrom;
  final int? priceTo;

  FilterModel({
    this.categoryId,
    this.translatorId,
    this.languageId,
    this.publisherId,
    this.isNew,
    this.priceFrom,
    this.priceTo,
  });

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'translatorId': translatorId,
      'languageId': languageId,
      'publisherId': publisherId,
      'isNew': isNew,
      'priceFrom': priceFrom,
      'priceTo': priceTo,
    };
  }

  @override
  String toString() {
    return 'FilterModel(categoryId: $categoryId, translatorId: $translatorId, languageId: $languageId, publisherId: $publisherId, isNew: $isNew, priceFrom: $priceFrom, priceTo: $priceTo)';
  }
}
