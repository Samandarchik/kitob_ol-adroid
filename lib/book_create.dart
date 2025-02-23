import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class BookCreatePage extends StatefulWidget {
  @override
  _BookCreatePageState createState() => _BookCreatePageState();
}

class _BookCreatePageState extends State<BookCreatePage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorIdController = TextEditingController();
  final TextEditingController categoryIdController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController publishedYearController = TextEditingController();
  final TextEditingController publisherIdController = TextEditingController();
  final TextEditingController sellerIdController = TextEditingController();
  final TextEditingController cityIdController = TextEditingController();
  final TextEditingController districtIdController = TextEditingController();

  final Dio _dio = Dio();

  // Token
  final String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InNhbWFuZGFyaWs0QGdtYWlsLmNvbSIsImV4cCI6MTc0MDMxMTg1MiwiaWF0IjoxNzQwMjI1NDUyLCJwaG9uZV9udW1iZXIiOiIrOTk4NzcwNDUxMTE3Iiwicm9sZSI6InVzZXIiLCJ1c2VyX2lkIjoiZThjYzY1NDAtNjYwOS00YzZmLThiOGUtMmYxOGQyMDE2ODdkIn0.hfVPbOgMCGwa7mqPa2FOizaV7ckhoopkVQwP-1tvvDU";

  Future<void> createBook() async {
    final String apiUrl = "https://gateway.axadjonovsardorbek.uz/books/create";

    final Map<String, dynamic> bookData = {
      "author_id": authorIdController.text,
      "category_id": categoryIdController.text,
      "cover_format": "Hardcover",
      "cover_type": "Paper",
      "description": descriptionController.text,
      "image_url":
          "https://images.axadjonovsardorbek.uz/kitobol/83a38301-0f8d-45f4-8321-83273b8b567cimage_picker_A7FCBD04-6576-42F5-BB34-8B5C8FECF7C5-57125-0000004C23544BAF.jpg.jpg",
      "img_url":
          "https://images.axadjonovsardorbek.uz/kitobol/83a38301-0f8d-45f4-8321-83273b8b567cimage_picker_A7FCBD04-6576-42F5-BB34-8B5C8FECF7C5-57125-0000004C23544BAF.jpg.jpg",
      "is_new": true,
      "language_id": "uz",
      "location": {
        "city_id": cityIdController.text,
        "district_id": districtIdController.text,
      },
      "price": int.tryParse(priceController.text) ?? 0,
      "published_year": publishedYearController.text,
      "publisher_id": publisherIdController.text,
      "seller_id": sellerIdController.text,
      "shitrix_code": "123456",
      "stock": 10,
      "title": titleController.text,
      "total_pages": 250,
      "translator_id": "translator_123",
      "writing_type": "Fiction"
    };

    try {
      final response = await _dio.post(
        apiUrl,
        data: bookData,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Kitob muvaffaqiyatli qo‘shildi!")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Xatolik yuz berdi: ${response.data}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Xatolik: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kitob Qo‘shish")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Kitob nomi"),
            ),
            TextField(
              controller: authorIdController,
              decoration: InputDecoration(labelText: "Muallif ID"),
            ),
            TextField(
              controller: categoryIdController,
              decoration: InputDecoration(labelText: "Kategoriya ID"),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: "Tavsif"),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: "Narx"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: publishedYearController,
              decoration: InputDecoration(labelText: "Nashr yili"),
            ),
            TextField(
              controller: publisherIdController,
              decoration: InputDecoration(labelText: "Nashriyot ID"),
            ),
            TextField(
              controller: sellerIdController,
              decoration: InputDecoration(labelText: "Sotuvchi ID"),
            ),
            TextField(
              controller: cityIdController,
              decoration: InputDecoration(labelText: "Shahar ID"),
            ),
            TextField(
              controller: districtIdController,
              decoration: InputDecoration(labelText: "Tuman ID"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: createBook,
              child: Text("Kitobni Yuborish"),
            ),
          ],
        ),
      ),
    );
  }
}
