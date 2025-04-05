import 'package:flutter/material.dart';
import 'package:kitob_ol/home/model/favourite_model.dart';
import 'package:kitob_ol/home/service/filter_book_res.dart';
import 'package:kitob_ol/home/service/get_filter.dart';
import 'package:kitob_ol/text_style.dart';

class FilterUi extends StatefulWidget {
  final FilterModel filterModel;
  const FilterUi({super.key, required this.filterModel});

  @override
  State<FilterUi> createState() => _FilterUiState();
}

class _FilterUiState extends State<FilterUi> {
  List<BookModel> books = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchFilteredBooks();
  }

  Future<void> fetchFilteredBooks() async {
    final List<BookModel>? books =
        await GetFilter().fetchFilteredBooks(widget.filterModel);
    setState(() {
      this.books = books ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Kitoblar",
            style: kTSB,
          ),
        ),
        body: FilterBookRes(
          books: books,
        ));
  }
}
