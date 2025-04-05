import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kitob_ol/provider.dart';
import 'package:provider/provider.dart';
import 'package:kitob_ol/get_filter_service.dart';
import 'package:kitob_ol/kam.dart';
import 'package:kitob_ol/home/model/category_model.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  final TextEditingController languageController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController publisherController = TextEditingController();
  final TextEditingController controller = TextEditingController();

  bool isNew = false;
  List<Language> languages = [];
  List<Author> authors = [];
  List<Category> categories = [];
  List<Publisher> publishers = [];

  @override
  void initState() {
    super.initState();
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
  Widget build(BuildContext context) {
    var filterProvider = Provider.of<FilterProvider>(context);

    return Column(
      children: [
        CustomDropdown(
          label: "selectLang".tr(),
          items: languages
              .map((e) => {
                    "id": e.id,
                    "name": e.name['uz'] ?? e.name['en'] ?? "Unknown"
                  })
              .toList(),
          controller: languageController,
          onChanged: (value) {
            setState(() {
              languageController.text =
                  languages.firstWhere((e) => e.id == value).name['uz'] ??
                      "Unknown";
            });
            filterProvider.setLanguage(value!);
          },
        ),
        CustomDropdown(
          label: "selectAuthor".tr(),
          items: authors
              .map((e) => {"id": e.id, "name": "${e.name} ${e.surname}"})
              .toList(),
          controller: authorController,
          onChanged: (value) {
            setState(() {
              authorController.text =
                  authors.firstWhere((e) => e.id == value).name;
            });
            filterProvider.setAuthor(value!);
          },
        ),
        CustomDropdown(
          label: "selectCategory".tr(),
          items: categories
              .map((e) => {
                    "id": e.id,
                    "name": e.name['uz'] ?? e.name['en'] ?? "Unknown"
                  })
              .toList(),
          controller: categoryController,
          onChanged: (value) {
            setState(() {
              categoryController.text =
                  categories.firstWhere((e) => e.id == value).name['uz'] ??
                      "Unknown";
            });
            filterProvider.setCategory(value!);
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
            filterProvider.setPublisher(value!);
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
          onChanged: (value) {
            filterProvider.setBookStatus(value);
          },
        ),
      ],
    );
  }
}
