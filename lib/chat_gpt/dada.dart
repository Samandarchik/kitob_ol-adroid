import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookDetailsScreen extends StatefulWidget {
  final int bookId;

  const BookDetailsScreen({required this.bookId, Key? key}) : super(key: key);

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  late Map<String, dynamic> bookDetails;
  int? viewCount;

  @override
  void initState() {
    super.initState();
    fetchBookDetails();
  }

  Future<void> fetchBookDetails() async {
    try {
      // Kitoblar ro'yxatini olish
      final listUrl =
          Uri.parse("https://gateway.axadjonovsardorbek.uz/books/list");
      final listResponse = await http.get(listUrl);

      if (listResponse.statusCode == 200) {
        final List books = jsonDecode(listResponse.body);

        // Kitobni topish
        final book = books.firstWhere((b) => b['id'] == widget.bookId,
            orElse: () => null);

        if (book != null) {
          setState(() {
            bookDetails = book;
          });

          // View count ni olish
          final viewCountUrl = Uri.parse(
              "https://gateway.axadjonovsardorbek.uz/books/get/full?book_id=${widget.bookId}");
          final viewCountResponse = await http.get(viewCountUrl);

          if (viewCountResponse.statusCode == 200) {
            final data = jsonDecode(viewCountResponse.body);
            setState(() {
              viewCount = data['view_count'];
            });
          }
        }
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Details'),
      ),
      body: bookDetails == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title: ${bookDetails['title'] ?? 'N/A'}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text('Author: ${bookDetails['author'] ?? 'N/A'}'),
                  const SizedBox(height: 10),
                  Text('Description: ${bookDetails['description'] ?? 'N/A'}'),
                  const SizedBox(height: 10),
                  Text('View Count: ${viewCount ?? 'Loading...'}'),
                ],
              ),
            ),
    );
  }
}
