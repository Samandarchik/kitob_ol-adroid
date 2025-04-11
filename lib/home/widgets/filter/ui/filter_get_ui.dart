import 'package:flutter/material.dart';
import 'package:kitob_ol/home/model/book_model.dart';
import 'package:kitob_ol/home/model/filter_model.dart';
import 'package:kitob_ol/home/service/get_filter.dart';
import 'package:kitob_ol/home/widgets/filter/widgets/filter_book_res.dart';
import 'package:kitob_ol/text_style.dart';

class FilterGetUi extends StatefulWidget {
  final FilterModel filterModel;
  const FilterGetUi({super.key, required this.filterModel});

  @override
  State<FilterGetUi> createState() => _FilterGetUiState();
}

class _FilterGetUiState extends State<FilterGetUi> {
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
        body: FilterBookResponse(
          books: books,
        ));
  }
}
