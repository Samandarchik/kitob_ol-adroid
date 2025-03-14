import 'package:flutter/material.dart';
import 'package:kitob_ol/home/model/favourite_model.dart';
import 'package:kitob_ol/home/ui/details.dart';
import 'package:kitob_ol/home/service/book_service.dart';
import 'package:kitob_ol/widget/my_card.dart';

class BookList extends StatefulWidget {
  final List<BookModel> books;
  const BookList({super.key, required this.books});

  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {
// futureBooks = BookService().fetchBooks();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, // Ensures ListView doesn't take all space
      physics: NeverScrollableScrollPhysics(),
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
    );
  }
}
