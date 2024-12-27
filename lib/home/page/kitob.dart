import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kitob_ol/home/modul/books_list.dart';
import 'package:kitob_ol/home/page/details.dart';
import 'package:kitob_ol/home/service/books_list.dart';
import 'package:kitob_ol/widget/my_card.dart';

class Book extends StatefulWidget {
  final int priceMin;
  final int priceMax;
  const Book({super.key, required this.priceMin, required this.priceMax});

  @override
  State<Book> createState() => _BookState();
}

class _BookState extends State<Book> {
  late Future<List<PostModel>> getApi;
  @override
  void initState() {
    super.initState();
    // API'dan ma'lumot olishni initState'da boshlaymiz
    getApi = BooksList().getData(widget.priceMin, widget.priceMax);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kitoblar Ro'yhati"),
      ),
      body: FutureBuilder(
          future: getApi,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text("Xatolik yuz berdi"),
              );
            }
            return MasonryGridView.builder(
              gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var data = snapshot.data![index];
                return MyCard(
                  title: data.title,
                  index: index,
                  price: data.price,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Details(
                                description: data.description,
                                publishedYear: data.publishedYear,
                                id: data.id,
                                sellerId: data.sellerId,
                                publisherId: data.publisherId,
                                categoryId: data.categoryId,
                                translatorId: data.translatorId,
                                authorId: data.authorId,
                                languageId: data.languageId,
                                title: data.title,
                                totalPages: data.totalPages,
                                price: data.price,
                                imageUrl: data.imageUrl,
                                imgUrl: data.imgUrl,
                                writingType: data.writingType,
                                viewCount: data.viewCount,
                                location: data.location,
                                coverType: data.coverType,
                                coverFormat: data.coverFormat,
                                shitrixCode: data.shitrixCode,
                                createdAt: data.createdAt,
                                isNew: data.isNew ??= false)));
                  },
                  city: 'aaa',
                  image: data.imageUrl,
                  isFavorite: true,
                );
              },
            );
          }),
    );
  }
}
