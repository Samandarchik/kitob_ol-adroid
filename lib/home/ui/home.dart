import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/core/data/local/token_storage.dart';
import 'package:kitob_ol/core/di/di.dart';
import 'package:kitob_ol/home/model/favourite_model.dart';
import 'package:kitob_ol/home/service/book_service.dart';
import 'package:kitob_ol/home/service/filter_widget_ui.dart';
import 'package:kitob_ol/home/ui/ish.dart';
import 'package:kitob_ol/home/ui/book_list.dart';
import 'package:kitob_ol/text_style.dart';
import 'package:kitob_ol/widget/app_bar.dart';
import 'package:kitob_ol/widget/drawer.dart';
import 'package:kitob_ol/widget/my_botton_text.dart';
import 'package:kitob_ol/widget/slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BookService bookService = BookService();
  List<BookModel> futureBooks = [];
  bool book = true; // Initially, we show books by default

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    // tokenstorage.getToken();
    final books = await bookService.fetchBooks();
    setState(() {
      futureBooks = books;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const MyAppBar(),
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MySlider(),
              const SizedBox(height: 20),
              MyElevedButtonBorder(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FilterPage()),
                  );
                },
                text: "filter".tr(),
              ),

              const SizedBox(height: 10),
              // Book button
              MyBottonText(
                top: 10,
                textColor: book ? kGrey : imageColor,
                onTap: () {
                  setState(() {
                    book = true; // Switch to show books
                  });
                },
                text: "books".tr(),
                boxColor: book ? imageColor : kGrey,
              ),
              // Job button
              MyBottonText(
                top: 10,
                textColor: book ? imageColor : kGrey,
                onTap: () {
                  setState(() {
                    book = false; // Switch to show jobs
                  });
                },
                text: "vacancy".tr(),
                boxColor: book ? kGrey : imageColor,
              ),
              const SizedBox(height: 18),
              Text(
                book ? "bookList".tr() : "vacancyList".tr(),
                style: kTSFWB18, // This defines the text style
              ),
              SizedBox(height: 10),
              IndexedStack(index: book ? 0 : 1, children: [
                BookList(books: futureBooks),
                IshList(),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
