import 'package:flutter/material.dart';
import 'package:kitob_ol/favorete_vacan_detail.dart';
import 'package:kitob_ol/home/model/book_model_favorite.dart';
import 'package:kitob_ol/home/service/book_job__favorite_service.dart';
import 'package:kitob_ol/home/ui/details_favorite.dart';
import 'package:kitob_ol/home/model/job_model.dart';
import 'package:kitob_ol/main.dart';
import 'package:kitob_ol/provider_auth.dart';
import 'package:kitob_ol/widget/favorite_card.dart';
import 'package:provider/provider.dart';

class FavoriteGet extends StatefulWidget {
  @override
  _FavoriteGetState createState() => _FavoriteGetState();
}

class _FavoriteGetState extends State<FavoriteGet> {
  final ApiServiceFavorites apiService = ApiServiceFavorites();
  @override
  Widget build(BuildContext context) {
    bool isRegister =
        Provider.of<AuthProvider>(context, listen: false).token != null;
    return Scaffold(
      appBar: AppBar(title: Text('Kitoblar va Ishlar')),
      body: isRegister
          ? FutureBuilder<Map<String, dynamic>>(
              future: apiService.fetchData(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Text("so'rov yuborilmoqda"));
                } else if (snapshot.hasError) {
                  return Center(child: Text('Xatolik yuz berdi'));
                } else {
                  List<BookModelFavorite> books = snapshot.data!['books'];
                  List<JobModel> jobs = snapshot.data!['jobs'];

                  return Column(
                    children: [
                      Expanded(
                        // 📌 ListView balandligini avtomatik cheklaydi
                        child: ListView(
                          padding: EdgeInsets.all(8.0),
                          children: [
                            // 📚 Kitoblar bo‘limi
                            Text(
                              '📚 Kitoblar',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8), // ✅ Bo‘sh joy qo‘shildi

                            // 📚 Kitoblar ro‘yxati
                            ListView.builder(
                              shrinkWrap:
                                  true, // 📌 ListView balandligini minimallashtiradi
                              physics:
                                  NeverScrollableScrollPhysics(), // 📌 Faqat bitta ListView scroll qiladi
                              itemCount: books.length,
                              itemBuilder: (context, index) {
                                var book = books[index];
                                return FavoriteCard(
                                  book: book,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailsFavorite(book: book),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),

                            SizedBox(height: 16), // ✅ Bo‘sh joy qo‘shildi

                            // 💼 Ishlar bo‘limi
                            Text(
                              '💼 Ishlar',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),

                            // 💼 Ish ro‘yxati
                            ListView.builder(
                              shrinkWrap:
                                  true, // 📌 ListView balandligini minimallashtiradi
                              physics:
                                  NeverScrollableScrollPhysics(), // 📌 Faqat bitta ListView scroll qiladi
                              itemCount: jobs.length,
                              itemBuilder: (context, index) {
                                var job = jobs[index];
                                return FavoreteVacanDetail(
                                  ish: job,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
            )
          : Center(
              child: Text("Resigter"),
            ),
    );
  }
}
