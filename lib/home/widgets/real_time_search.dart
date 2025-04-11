import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kitob_ol/home/model/category_model.dart';
import 'package:kitob_ol/home/widgets/filter_search_field.dart';
import 'package:kitob_ol/get_filter_service.dart';

class FilterWidget extends StatefulWidget {
  String? selectedLanguageId;
  String? selectedAuthorId;
  String? selectedCategoryId;
  String? selectedPublisherId;
  bool? isNew;

  // Add callback functions
  final Function(String?) onLanguageChanged;
  final Function(String?) onAuthorChanged;
  final Function(String?) onCategoryChanged;
  final Function(String?) onPublisherChanged;
  final Function(bool?) onNewStatusChanged;

  FilterWidget({
    super.key,
    required this.selectedLanguageId,
    required this.selectedAuthorId,
    required this.selectedCategoryId,
    required this.selectedPublisherId,
    required this.isNew,
    required this.onLanguageChanged,
    required this.onAuthorChanged,
    required this.onCategoryChanged,
    required this.onPublisherChanged,
    required this.onNewStatusChanged,
  });

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  List<Language> languages = [];
  List<Author> authors = [];
  List<Cities> cities = [];
  List<Category> categories = [];
  List<Publisher> publishers = [];

  // Selected values

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    setState(() {
      isLoading = true;
    });

    try {
      languages = await ApiService.fetchLanguages();
      authors = await ApiService.fetchAuthors();
      categories = await ApiService.fetchCategories();
      publishers = await ApiService.fetchPublishers();

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Language Filter
                Text(
                  'selectLanguage'.tr(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 8),
                FilterSearchField<Language>(
                  items: languages,
                  itemToString: (language) =>
                      language.name[context.locale.languageCode] ?? 'Unknown',
                  itemToId: (language) => language.id,
                  selectedId: widget.selectedLanguageId,
                  hintText: 'searchLanguage'.tr(),
                  onSelected: (language) {
                    setState(() {
                      widget.selectedLanguageId = language.id;
                    });
                  },
                ),
                const SizedBox(height: 24),

                // Author Filter
                Text(
                  'selectAuthor'.tr(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 8),
                FilterSearchField<Author>(
                  items: authors,
                  itemToString: (author) => "${author.name} ${author.surname}",
                  itemToId: (author) => author.id,
                  selectedId: widget.selectedAuthorId,
                  hintText: 'searchAuthor'.tr(),
                  onSelected: (author) {
                    setState(() {
                      widget.selectedAuthorId = author.id;
                    });
                  },
                ),
                const SizedBox(height: 24),

                // Category Filter
                Text(
                  'selectCategory'.tr(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 8),
                FilterSearchField<Category>(
                  items: categories,
                  itemToString: (category) =>
                      category.name[context.locale.languageCode] ?? 'Unknown',
                  itemToId: (category) => category.id,
                  selectedId: widget.selectedCategoryId,
                  hintText: 'searchCategory'.tr(),
                  onSelected: (category) {
                    setState(() {
                      widget.selectedCategoryId = category.id;
                    });
                  },
                ),
                const SizedBox(height: 24),

                // Publisher Filter
                Text(
                  'selectPublisher'.tr(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 8),
                FilterSearchField<Publisher>(
                  items: publishers,
                  itemToString: (publisher) => publisher.name,
                  itemToId: (publisher) => publisher.id,
                  selectedId: widget.selectedPublisherId,
                  hintText: 'searchPublisher'.tr(),
                  onSelected: (publisher) {
                    setState(() {
                      widget.selectedPublisherId = publisher.id;
                    });
                  },
                ),
                const SizedBox(height: 24),

                // Book Status Filter
                Text(
                  'selectBookStatus'.tr(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: DropdownButtonFormField<bool?>(
                    value: widget.isNew,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            const BorderSide(color: Colors.indigo, width: 1.5),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 20,
                      ),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: null,
                        child: Text('all'.tr()),
                      ),
                      DropdownMenuItem(
                        value: true,
                        child: Text('new'.tr()),
                      ),
                      DropdownMenuItem(
                        value: false,
                        child: Text('old'.tr()),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        widget.isNew = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
