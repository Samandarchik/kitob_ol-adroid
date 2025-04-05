import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kitob_ol/category_list.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/home/service/book_service.dart';
import 'package:kitob_ol/home/service/filter_ui.dart';
import 'package:kitob_ol/home/service/get_filter.dart';
import 'package:kitob_ol/login/service/token.dart';
import 'package:kitob_ol/provider.dart';
import 'package:kitob_ol/widget/my_botton_text.dart';
import 'package:kitob_ol/widget/text_class.dart';
import 'package:provider/provider.dart';

double minPrice = 1;
double maxPrice = 100000;

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  TextClass textClass = TextClass();
  TokenStorage tokenStorage = TokenStorage();
  TextEditingController controller = TextEditingController();
  RangeValues _currentRangeValues = RangeValues(minPrice, maxPrice);

  @override
  void initState() {
    super.initState();
    fetchPriceRange();
  }

  Future<void> fetchPriceRange() async {
    await BookService()
        .fetchBooks(); // fetchBooks ichida minPrice va maxPrice yangilanadi
    await tokenStorage.getPrice();

    setState(() {
      _currentRangeValues = RangeValues(minPrice, maxPrice);
      print("minPrice: $minPrice, maxPrice: $maxPrice");
    });
  }

  final FilterModel filter = FilterModel();

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProvider>(context, listen: false);

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
                CategoryList(),

                SizedBox(height: 10),
                Text(
                  'price'.tr(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                // Price Range Slider
                RangeSlider(
                  values: _currentRangeValues,
                  min: minPrice ?? 0,
                  max: maxPrice ?? 10000,
                  divisions: (maxPrice! - minPrice!) ~/ 1000,
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
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FilterUi(
                                filterModel: FilterModel(
                                    languageId: filterProvider.selectedLanguage,
                                    translatorId: filterProvider.selectedAuthor,
                                    categoryId: filterProvider.selectedCategory,
                                    priceFrom:
                                        _currentRangeValues.start.toInt(),
                                    priceTo:
                                        _currentRangeValues.end.toInt())))),
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
