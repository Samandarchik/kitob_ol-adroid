import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/core/data/local/token_storage.dart';
import 'package:kitob_ol/core/di/di.dart';
import 'package:kitob_ol/home/widgets/real_time_search.dart';
import 'package:kitob_ol/home/service/book_service.dart';
import 'package:kitob_ol/home/model/filter_model.dart';
import 'package:kitob_ol/home/widgets/filter/ui/filter_get_ui.dart';
import 'package:kitob_ol/widget/my_botton_text.dart';
import 'package:kitob_ol/widget/text_class.dart';

double minPrice = 1;
double maxPrice = 100000;

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  TextClass textClass = TextClass();
  TokenStorage tokenStorage = sl<TokenStorage>();
  RangeValues _currentRangeValues = RangeValues(minPrice, maxPrice);
  String? selectedLanguage;
  String? selectedAuthor;
  String? selectedCategory;
  String? selectedPublisher;
  String? selectedCountry;
  String? selectedCity;
  String? selectedYear;
  String? selectedTranslation;
  bool? isNew;

  @override
  void initState() {
    super.initState();
    fetchPriceRange();
  }

  Future<void> fetchPriceRange() async {
    await BookService()
        .fetchBooks(1); // fetchBooks ichida minPrice va maxPrice yangilanadi
    await tokenStorage.getPrice();

    setState(() {
      _currentRangeValues = RangeValues(minPrice, maxPrice);
      print("minPrice: $minPrice, maxPrice: $maxPrice");
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("filter".tr()),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FilterWidget(
                  selectedLanguageId: selectedLanguage,
                  selectedAuthorId: selectedAuthor,
                  selectedCategoryId: selectedCategory,
                  selectedPublisherId: selectedPublisher,
                  isNew: isNew,
                  onLanguageChanged: (String? id) {
                    setState(() {
                      selectedLanguage = id;
                    });
                    print("Til o'zgartirildi: $id");
                  },
                  onAuthorChanged: (String? id) {
                    setState(() {
                      selectedAuthor = id;
                    });
                    print("Muallif o'zgartirildi: $id");
                  },
                  onCategoryChanged: (String? id) {
                    setState(() {
                      selectedCategory = id;
                    });
                    print("Kategoriya o'zgartirildi: $id");
                  },
                  onPublisherChanged: (String? id) {
                    setState(() {
                      selectedPublisher = id;
                    });
                    print("Nashriyot o'zgartirildi: $id");
                  },
                  onNewStatusChanged: (bool? value) {
                    setState(() {
                      isNew = value;
                    });
                    print("Kitob holati o'zgartirildi: $value");
                  },
                ),

                SizedBox(height: 10),
                Text(
                  'price'.tr(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                // Price Range Slider
                RangeSlider(
                  values: _currentRangeValues,
                  min: minPrice,
                  max: maxPrice,
                  divisions: (maxPrice - minPrice) ~/ 1000,
                  activeColor: const Color(0xff2C3033),
                  inactiveColor: const Color(0xffE0E0E0),
                  onChanged: (RangeValues values) {
                    setState(() {
                      _currentRangeValues = RangeValues(
                        (values.start / 1000).round() *
                            1000, // 1,000 lik qiymatlarga tekislash
                        (values.end / 1000).round() * 1000,
                      );
                    });
                    print(
                        "Narx oralig'i o'zgartirildi: ${_currentRangeValues.start.toInt()} - ${_currentRangeValues.end.toInt()}");
                  },
                ),

                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    price(size, _currentRangeValues.start.toInt()),
                    Container(
                      height: 56,
                      color: kGreyBorder,
                      width: 2,
                    ),
                    price(size, _currentRangeValues.end.toInt()),
                  ],
                ),
                MyBottonText(
                    top: 10,
                    textColor: kWhite,
                    onTap: () {
                      print("Qidirish tugmasi bosildi");
                      print("Til: $selectedLanguage");
                      print("Muallif: $selectedAuthor");
                      print("Kategoriya: $selectedCategory");
                      print("Nashriyot: $selectedPublisher");
                      print("Tarjimon: $selectedTranslation");
                      print("Yangi: $isNew");
                      print(
                          "Narx oralig'i: ${_currentRangeValues.start.toInt()} - ${_currentRangeValues.end.toInt()}");

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FilterGetUi(
                                  filterModel: FilterModel(
                                      categoryId: selectedCategory,
                                      translatorId: selectedTranslation,
                                      languageId: selectedLanguage,
                                      publisherId: selectedPublisher,
                                      isNew: isNew,
                                      priceFrom:
                                          _currentRangeValues.start.toInt(),
                                      priceTo:
                                          _currentRangeValues.end.toInt()))));
                    },
                    text: "search".tr(),
                    boxColor: imageColor),
              ],
            ),
          ),
        ));
  }

  Container price(Size size, int price) {
    return Container(
      width: size.width * .45,
      height: 56,
      decoration: const BoxDecoration(
        color: kGreyContainer,
      ),
      child: Center(
        child: Text(
          '${textClass.formatNumberWithSpaces(price)} ${"sum".tr()}',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
