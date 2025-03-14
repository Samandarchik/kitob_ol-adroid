import 'package:flutter/material.dart';
import 'package:kitob_ol/home/model/favourite_model.dart';
import 'package:kitob_ol/home/ui/details.dart';
import 'package:kitob_ol/home/service/book_service.dart';
import 'package:kitob_ol/widget/my_card.dart';

class FilterBookRes extends StatefulWidget {
  final List<BookModel> books;
  const FilterBookRes({super.key, required this.books});

  @override
  _FilterBookResState createState() => _FilterBookResState();
}

class _FilterBookResState extends State<FilterBookRes> {
  @override
  Widget build(BuildContext context) {
    return widget.books.isEmpty
        ? Center(
            child: Text(
              "Kitoblar topilmadi",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Details(
                                  book: book,
                                )));
                    await BookService().getBook(book.id!);
                  },
                );
              },
            ),
          );
  }
}
