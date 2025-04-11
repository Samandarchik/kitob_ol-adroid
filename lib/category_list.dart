import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kitob_ol/get_filter_service.dart';
import 'package:kitob_ol/kam.dart';
import 'package:kitob_ol/home/model/category_model.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  late final SearchController languageController;
  late final TextEditingController authorController;
  late final TextEditingController categoryController;
  late final TextEditingController publisherController;
  late final TextEditingController controller;

  bool isNew = false;
  List<Language> languages = [];
  List<Author> authors = [];
  List<Category> categories = [];
  List<Publisher> publishers = [];

  @override
  void initState() {
    super.initState();
    languageController = SearchController();
    authorController = TextEditingController();
    categoryController = TextEditingController();
    publisherController = TextEditingController();
    controller = TextEditingController();
    _fetchData();
  }

  void _fetchData() async {
    try {
      languages = await ApiService.fetchLanguages();
      authors = await ApiService.fetchAuthors();
      categories = await ApiService.fetchCategories();
      publishers = await ApiService.fetchPublishers();
      setState(() {});
    } catch (e) {
      print("Xatolik: $e");
    }
  }

  @override
  void dispose() {
    super.dispose();
    languageController.dispose();
    authorController.dispose();
    categoryController.dispose();
    publisherController.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomDropdown(
          label: "selectAuthor".tr(),
          items: authors
              .map((e) => {"id": e.id, "name": "${e.name} ${e.surname}"})
              .toList(),
          controller: authorController,
          onChanged: (value) {
            setState(() {
              languages = languages
                  .where((lang) => lang.name[context.locale.languageCode]!
                      .toLowerCase()
                      .contains(value!.toLowerCase()))
                  .toList();
            });
          },
        ),
        CustomDropdown(
          label: "selectCategory".tr(),
          items: categories
              .map((e) => {
                    "id": e.id,
                    "name": e.name[context.locale.languageCode] ??
                        e.name['en'] ??
                        "Unknown"
                  })
              .toList(),
          controller: categoryController,
          onChanged: (value) {
            setState(() {
              categoryController.text = categories
                      .firstWhere((e) => e.id == value)
                      .name[context.locale.languageCode] ??
                  "Unknown";
            });
          },
        ),
        CustomDropdown(
          label: "selectPublisher".tr(),
          items: publishers.map((e) => {"id": e.id, "name": e.name}).toList(),
          controller: publisherController,
          onChanged: (value) {
            setState(() {
              publisherController.text =
                  publishers.firstWhere((e) => e.id == value).name;
            });
          },
        ),
        CustomDropdown(
          label: "selectBookStatus".tr(),
          items: [
            {"id": null, "name": "all".tr()},
            {"id": "true", "name": "new".tr()},
            {"id": "false", "name": "old".tr()},
          ],
          controller: controller,
          onChanged: (value) {},
        ),
      ],
    );
  }
}
