import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kitob_ol/home/model/book_model.dart';
import 'package:kitob_ol/home/service/book_service.dart';
import 'package:kitob_ol/text_style.dart';
import 'package:kitob_ol/widget/my_card.dart';

class FilterBookResponse extends StatefulWidget {
  final List<BookModel> books;
  const FilterBookResponse({super.key, required this.books});

  @override
  _FilterBookResponseState createState() => _FilterBookResponseState();
}

class _FilterBookResponseState extends State<FilterBookResponse> {
  BookService bookService = BookService();
  @override
  Widget build(BuildContext context) {
    return widget.books.isEmpty
        ? Center(
            child: Text(
              "notBook".tr(),
              style: kTSFWB18,
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.books.length,
              itemBuilder: (context, index) {
                BookModel book = widget.books[index];

                return MyCardBook(
                  book: book,
                );
              },
            ),
          );
  }
}
