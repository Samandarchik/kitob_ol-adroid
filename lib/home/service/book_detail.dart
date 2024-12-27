import 'dart:convert'; // JSONni dekodlash uchun
import 'package:http/http.dart' as http; // HTTP so'rovlarini yuborish uchun

class Exsam {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String publishedYear;
  final int totalPages;

  // Konstruktor
  Exsam({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.publishedYear,
    required this.totalPages,
  });

  // JSONni Dart modeliga aylantirish
  factory Exsam.fromJson(Map<String, dynamic> json) {
    return Exsam(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['image_url'],
      publishedYear: json['published_year'],
      totalPages: json['total_pages'],
    );
  }
}

// URLdan ma'lumotni olish
Future<Exsam> fetchBookData() async {
  final response = await http.get(Uri.parse(
      'https://gateway.axadjonovsardorbek.uz/books/list')); // Bu yerga o'zingizning URLni qo'ying

  if (response.statusCode == 200) {
    // Agar so'rov muvaffaqiyatli bo'lsa
    return Exsam.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Ma\'lumot olishda xatolik yuz berdi');
  }
}

void main() async {
  try {
    // Ma'lumotni olish
    Exsam book = await fetchBookData();
    print('Kitob nomi: ${book.title}');
    print('Kitob tavsifi: ${book.description}');
    print('Yili: ${book.publishedYear}');
    print('Sahifalar soni: ${book.totalPages}');
  } catch (e) {
    print('Xatolik: $e');
  }
}
