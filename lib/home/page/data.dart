import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// URL'lar
const String languageUrl =
    'https://gateway.axadjonovsardorbek.uz/languages/get';
const String authorUrl = 'https://gateway.axadjonovsardorbek.uz/authors/get';
const String translatorUrl =
    'https://gateway.axadjonovsardorbek.uz/translators/get';
const String categoryUrl =
    'https://gateway.axadjonovsardorbek.uz/categories/get';
const String publisherUrl =
    'https://gateway.axadjonovsardorbek.uz/publishers/get';
const String cityUrl = 'https://gateway.axadjonovsardorbek.uz/cities/get';

// Har bir URL'ga so'rov yuborib, ma'lumotlarni olish
Future<String> fetchData(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    // 'name' maydonini olish
    return jsonDecode(response.body)['name'];
  } else {
    throw Exception('Ma\'lumot olishda xatolik yuz berdi');
  }
}

// Book modelini yaratish
class Book {
  final String publisher;
  final String category;
  final String translator;
  final String author;
  final String language;

  Book({
    required this.publisher,
    required this.category,
    required this.translator,
    required this.author,
    required this.language,
  });

  // JSONdan obyektga aylantirish
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      publisher: json['91592a3f-2c18-4bbb-8f07-e23031bc2f8e'],
      category: json['5038cbeb-0b3b-450f-90b2-10a9ca1d68e5'],
      translator: json['94f3762b-8a7e-4872-8605-b91152248c01'],
      author: json['04b93547-f81a-4be2-8abb-af3f43b2c686'],
      language: json['ecf438ab-14c2-467f-9e1e-10626bc15ca5'],
    );
  }
}

class BookScreenData extends StatefulWidget {
  @override
  _BookScreenDataState createState() => _BookScreenDataState();
}

class _BookScreenDataState extends State<BookScreenData> {
  late Future<Book> bookDetails;

  @override
  void initState() {
    super.initState();
    bookDetails = fetchBookDetails(); // Kitob ma'lumotlarini olish
  }

  // Barcha URL'larga so'rov yuborish va ma'lumotlarni birlashtirish
  Future<Book> fetchBookDetails() async {
    var publisherFuture = fetchData(publisherUrl);
    var categoryFuture = fetchData(categoryUrl);
    var translatorFuture = fetchData(translatorUrl);
    var authorFuture = fetchData(authorUrl);
    var languageFuture = fetchData(languageUrl);
    var cityFuture = fetchData(cityUrl);

    List<String> results = await Future.wait([
      publisherFuture,
      categoryFuture,
      translatorFuture,
      authorFuture,
      languageFuture,
      cityFuture
    ]);

    return Book(
      publisher: results[0],
      category: results[1],
      translator: results[2],
      author: results[3],
      language: results[4],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kitob Ma\'lumotlari'),
      ),
      body: Center(
        child: FutureBuilder<Book>(
          future: bookDetails,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Yüklashda ko'rsatiladigan spinner
            } else if (snapshot.hasError) {
              return Text('Xatolik: ${snapshot.error}'); // Xato haqida xabar
            } else if (snapshot.hasData) {
              // Ma'lumotlar muvaffaqiyatli olingan bo'lsa
              Book book = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Publisher: ${book.publisher}',
                        style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    Text('Category: ${book.category}',
                        style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    Text('Translator: ${book.translator}',
                        style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    Text('Author: ${book.author}',
                        style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    Text('Language: ${book.language}',
                        style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    Text('City: ', style: TextStyle(fontSize: 18)),
                  ],
                ),
              );
            } else {
              return Text('No data available');
            }
          },
        ),
      ),
    );
  }
}
