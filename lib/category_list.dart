import 'package:flutter/material.dart';
import 'package:kitob_ol/provider.dart';
import 'package:provider/provider.dart';
import 'package:kitob_ol/get_filter_service.dart';
import 'package:kitob_ol/kam.dart';
import 'package:kitob_ol/model.dart';

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  bool isNew = false;
  List<Language> languages = [];
  List<Author> authors = [];
  List<Category> categories = [];
  List<Publisher> publishers = [];

  final TextEditingController languageController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController publisherController = TextEditingController();
  final TextEditingController controller = TextEditingController();

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
          label: "Tilni tanlang",
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
          label: "Muallifni tanlang",
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
          label: "Kategoriya tanlang",
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
          label: "Nashriyotni tanlang",
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
          label: "Kitob holatini tanlang",
          items: [
            {"id": null, "name": "Hammasi"},
            {"id": "true", "name": "Yangi"},
            {"id": "false", "name": "Eski"},
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
