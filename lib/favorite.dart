import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/core/data/local/token_storage.dart';
import 'package:kitob_ol/core/di/di.dart';
import 'package:kitob_ol/favorete_vacan_detail.dart';
import 'package:kitob_ol/home/model/book_model_favorite.dart';
import 'package:kitob_ol/home/service/book_job__favorite_service.dart';
import 'package:kitob_ol/home/ui/details_favorite.dart';
import 'package:kitob_ol/home/model/job_model.dart';
import 'package:kitob_ol/login/ui/register.dart';
import 'package:kitob_ol/text_style.dart';
import 'package:kitob_ol/widget/favorite_card.dart';
import 'package:kitob_ol/widget/my_botton_text.dart';

class FavoriteGet extends StatefulWidget {
  const FavoriteGet({super.key});

  @override
  _FavoriteGetState createState() => _FavoriteGetState();
}

class _FavoriteGetState extends State<FavoriteGet> {
  TokenStorage tokenStorage = sl<TokenStorage>();
  bool isBook = true;
  final ApiServiceFavorites apiService = ApiServiceFavorites();
  List<BookModelFavorite> books = [];
  List<JobModel> jobs = [];
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final bool isResgistered = tokenStorage.getToken().isEmpty;

    if (isResgistered) return;

    final data = await apiService.fetchData(context);

    setState(() {
      books = List<BookModelFavorite>.from(data['books']);
      jobs = List<JobModel>.from(data['jobs']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return tokenStorage.getToken().isNotEmpty
        ? DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                  title: Text(
                    'save'.tr(),
                    style: kTSB,
                  ),
                  bottom: TabBar(
                      indicatorColor: imageColor,
                      labelColor: Colors.black,
                      labelStyle: kTSB,
                      tabs: [
                        Tab(
                          text: " 📚 ${"books".tr()}",
                        ),
                        Tab(
                          text: " 💼 ${"vacancy".tr()}",
                        ),
                      ])),
              body: tokenStorage.getToken().isNotEmpty
                  ? TabBarView(children: [
                      book(books),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: job(jobs),
                      ),
                    ])
                  : Center(
                      child: Text("Resigter"),
                    ),
            ),
          )
        : _buildLoginPrompt();
  }

// 📌 Joblist
  ListView job(List<JobModel> jobs) {
    return ListView.builder(
      shrinkWrap: true, // 📌 ListView balandligini minimallashtiradi

      itemCount: jobs.length,
      itemBuilder: (context, index) {
        var job = jobs[index];
        return FavoreteVacanDetail(
          ish: job,
        );
      },
    );
  }

// 📌 Booklist
  ListView book(List<BookModelFavorite> books) {
    return ListView.builder(
      shrinkWrap: true, // 📌 ListView balandligini minimallashtiradi
      itemCount: books.length,
      itemBuilder: (context, index) {
        var book = books[index];
        return FavoriteCard(
          book: book,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsFavorite(book: book),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildLoginPrompt() {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("save".tr(), style: kTSB),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("login".tr(), style: kTSFWB18),
            Text(
              "loginText".tr(),
              style: kTSFS16,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            MyBottonText(
              boxColor: imageColor,
              textColor: kWhite,
              width: MediaQuery.of(context).size.width * 0.6,
              text: "createAkaunt".tr(),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Register()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
