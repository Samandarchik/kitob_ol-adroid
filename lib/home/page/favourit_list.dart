import 'package:flutter/material.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/home/page/favorite_detail.dart';
import 'package:kitob_ol/home/page/favourites_service.dart';
import 'package:kitob_ol/login/page/register.dart';
import 'package:kitob_ol/text_style.dart';
import 'package:kitob_ol/widget/favorite_card.dart';
import 'package:kitob_ol/widget/my_botton_text.dart';

class FavouritList extends StatefulWidget {
  const FavouritList({super.key});

  @override
  _FavouritListState createState() => _FavouritListState();
}

class _FavouritListState extends State<FavouritList> {
  late Future<List<BookListFavorite>> futureBooks;
  bool isRegister = false;
  @override
  void initState() {
    super.initState();
    futureBooks = FavouritesService().fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Saqlanganlar",
          style: kTSFWB18,
        ),
      ),
      body: isRegister
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<List<BookListFavorite>>(
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
                    List<BookListFavorite> books = snapshot.data!;
                    return ListView.builder(
                      itemCount: books.length,
                      itemBuilder: (context, index) {
                        BookListFavorite book = books[index];
                        return FavoriteCard(
                          book: book,
                          onTap: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FavoriteDetail(
                                          book: book,
                                        )));
                          },
                        );
                      },
                    );
                  }
                },
              ),
            )
          : Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Tizimga kirish",
                  style: kTSFWB18,
                ),
                Text(
                  "Saqlanganlar faqatgina login \nqilgan foydalanuvchilar uchun",
                  style: kTSFS16,
                ),
                Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: MyBottonText(
                      boxColor: imageColor,
                      textColor: kWhite,
                      width: MediaQuery.of(context).size.width * .6,
                      text: "Ro'yxatdan o'tish",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Register()),
                        );
                      },
                    ))
              ],
            )),
    );
  }
}
