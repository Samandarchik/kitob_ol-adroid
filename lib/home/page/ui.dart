import 'package:flutter/material.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/home/modul/books_list.dart';
import 'package:kitob_ol/home/page/details.dart';
import 'package:kitob_ol/home/service/book_service.dart';
import 'package:kitob_ol/widget/my_card.dart';
import 'package:kitob_ol/widget/text_class.dart';

class BookListScreen extends StatefulWidget {
  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  late Future<List<Book>> futureBooks;

  @override
  void initState() {
    super.initState();
    futureBooks = BookService().fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreyBack,
      appBar: AppBar(title: Text("Book List")),
      body: FutureBuilder<List<Book>>(
        future: futureBooks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No books available"));
          } else {
            List<Book> books = snapshot.data!;
            return ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                Book book = books[index];
                return MyCard(
                    index: index,
                    price: book.price,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Details(
                                  id: book.id,
                                  description: book.description,
                                  sellerId: book.sellerName,
                                  publisherId: book.publisherName,
                                  categoryId: book.categoryName,
                                  translatorId: book.translatorName,
                                  authorId: book.authorName,
                                  languageId: book.languageName,
                                  title: book.title,
                                  totalPages: book.totalPages,
                                  price: book.price,
                                  imageUrl: book.imageUrl,
                                  imgUrl: book.imgUrl,
                                  writingType: book.writingType,
                                  viewCount: book.viewCount,
                                  cityName: book.cityName,
                                  coverType: book.coverType,
                                  coverFormat: book.coverFormat,
                                  shitrixCode: book.shitrixCode,
                                  createdAt: book.createdAt,
                                  isNew: book.isNew,
                                  publishedYear: book.publishedYear)));
                    },
                    title: book.title,
                    city: book.cityName,
                    image: book.imageUrl,
                    isFavorite: true);
              },
            );
          }
        },
      ),
    );
  }
}
