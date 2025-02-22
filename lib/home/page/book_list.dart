import 'package:flutter/material.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/home/model/books_modul.dart';
import 'package:kitob_ol/home/page/details.dart';
import 'package:kitob_ol/home/service/book_service.dart';
import 'package:kitob_ol/widget/my_card.dart';

class BookList extends StatefulWidget {
  const BookList({super.key});

  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  late Future<List<Book>> futureBooks;

  @override
  void initState() {
    super.initState();
    futureBooks = BookService().fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Book>>(
      future: futureBooks,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.all(20),
              height: 200,
              decoration: BoxDecoration(
                color: kGreyContainer,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("No books available"));
        } else {
          List<Book> books = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true, // Ensures ListView doesn't take all space
            physics: NeverScrollableScrollPhysics(),
            itemCount: books.length,
            itemBuilder: (context, index) {
              Book book = books[index];

              return MyCardBook(
                book: book,
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Details(
                                book: book,
                              )));
                  await BookService().getBook(book.id);
                },
              );
            },
          );
        }
      },
    );
  }
}
