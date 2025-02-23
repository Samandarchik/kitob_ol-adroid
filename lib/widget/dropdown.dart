// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:kitob_ol/home/service/get_filter.dart';

// class MyDropdown extends StatefulWidget {
//   final String url;
//   final String label;
//  final FilerData filerData; // FilerData ni qo'shamiz

//  const MyDropdown({
//     super.key,
//     required this.url,
//     required this.label,
//     required this.filerData, // Constructorga qo'shamiz
//   });

//   @override
//   State<MyDropdown> createState() => _MyDropdownState();
// }

// class _MyDropdownState extends State<MyDropdown> {
//   String? selectedLanguage;

//   @override
//   Widget build(BuildContext context) {
//     List<Map<String, String>> languages = [
//       {"id": "uz", "name": "O'zbek"},
//       {"id": "ru", "name": "Русский"}
//     ];
//     return Padding(
//       padding: const EdgeInsets.only(top: 12.0),
//       child: DropdownButtonFormField<String>(
//         decoration: InputDecoration(
//           labelText: widget.label,
//           hintText: "Tilni tanlang",
//           border: OutlineInputBorder(
//               borderRadius:
//                   BorderRadius.circular(12)), // 📌 Burchaklarni yumshatish
//           contentPadding:
//               const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//           prefixIcon:
//               Icon(Icons.language, color: Colors.blueAccent), // 🌍 Til ikonkasi
//         ),
//         icon: Icon(Icons.arrow_drop_down,
//             color: Colors.blueAccent), // 🔽 Pastga ochish ikonasi
//         items: languages.map((lang) {
//           return DropdownMenuItem<String>(
//             value: lang["id"],
//             child: Row(
//               children: [
//                 SizedBox(width: 10),
//                 Text(lang["name"] ?? "Noma'lum"),
//               ],
//             ),
//           );
//         }).toList(),
//         onChanged: (newValue) {
//           setState(() {
//             selectedLanguage = newValue;
//             widget.filerData.selectedLanguage = newValue;
//           });
//         },
//         value: selectedLanguage,
//       ),
//     );
//   }
// }

// class CategoryDropdown extends StatefulWidget {
//   final String url;
//   final String label;

//   const CategoryDropdown({super.key, required this.url, required this.label});

//   @override
//   State<CategoryDropdown> createState() => _CategoryDropdownState();
// }

// class _CategoryDropdownState extends State<CategoryDropdown> {
//   List<Map<String, String>> categories = [];
//   String? selectedCategory;

//   @override
//   void initState() {
//     super.initState();
//     fetchCategories();
//   }

//   FilerData filerData = FilerData();

//   Future<void> fetchCategories() async {
//     final response = await http.get(Uri.parse(widget.url));

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       final List<dynamic> categoryList = data['Categories']['categories'];

//       setState(() {
//         categories = categoryList
//             .map((json) => {
//                   "id": json["id"].toString(),
//                   "name": json["name"]["uz"].toString(),
//                 })
//             .toList();
//         print(categories[0]["id"]);
//       });
//     } else {
//       print("Xatolik: ${response.statusCode}");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 12.0),
//       child: DropdownButtonFormField<String>(
//         decoration: InputDecoration(
//           labelText: widget.label,
//           border: const OutlineInputBorder(),
//           contentPadding: const EdgeInsets.all(8),
//         ),
//         items: categories.map((category) {
//           return DropdownMenuItem<String>(
//             value: category["id"],
//             child: Text(category["name"] ?? "Noma'lum"),
//           );
//         }).toList(),
//         onChanged: (newValue) {
//           setState(() {
//             selectedCategory = newValue;
//             filerData.selectedCategory = newValue;
//           });
//         },
//         value: selectedCategory,
//       ),
//     );
//   }
// }

// class PublisherDropdown extends StatefulWidget {
//   final String url;
//   final String label;

//   const PublisherDropdown({super.key, required this.url, required this.label});

//   @override
//   State<PublisherDropdown> createState() => _PublisherDropdownState();
// }

// class _PublisherDropdownState extends State<PublisherDropdown> {
//   List<Map<String, String>> publishers = [];
//   String? selectedPublisher;

//   @override
//   void initState() {
//     super.initState();
//     fetchPublishers();
//   }

//   FilerData filerData = FilerData();

//   Future<void> fetchPublishers() async {
//     final response = await http.get(Uri.parse(widget.url));

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       final List<dynamic> publisherList = data['publishers'];

//       setState(() {
//         publishers = publisherList
//             .map((json) => {
//                   "id": json["id"].toString(),
//                   "name": json["name"].toString(),
//                 })
//             .toList();
//       });
//     } else {
//       print("Xatolik: ${response.statusCode}");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 12.0),
//       child: DropdownButtonFormField<String>(
//         decoration: InputDecoration(
//           labelText: widget.label,
//           border: const OutlineInputBorder(),
//           contentPadding: const EdgeInsets.all(8),
//         ),
//         items: publishers.map((publisher) {
//           return DropdownMenuItem<String>(
//             value: publisher["id"],
//             child: Text(publisher["name"] ?? "Noma'lum"),
//           );
//         }).toList(),
//         onChanged: (newValue) {
//           setState(() {
//             selectedPublisher = newValue;
//             filerData.selectedPublisher = newValue;
//           });
//         },
//         value: selectedPublisher,
//       ),
//     );
//   }
// }

// class AuthorDropdown extends StatefulWidget {
//   final String url;
//   final String label;

//   const AuthorDropdown({super.key, required this.url, required this.label});

//   @override
//   State<AuthorDropdown> createState() => _AuthorDropdownState();
// }

// class _AuthorDropdownState extends State<AuthorDropdown> {
//   List<Map<String, String>> authors = [];
//   String? selectedAuthor;
//   final FilerData filerData = FilerData();

//   @override
//   void initState() {
//     super.initState();
//     fetchAuthors();
//   }

//   Future<void> fetchAuthors() async {
//     final response = await http.get(Uri.parse(widget.url));

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       final List<dynamic> authorList = data['authors'];

//       setState(() {
//         authors = authorList
//             .map((json) => {
//                   "id": json["id"].toString(),
//                   "name": "${json["name"]} ${json["surname"]}",
//                 })
//             .toList();
//       });
//     } else {
//       print("Xatolik: ${response.statusCode}");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 12.0),
//       child: DropdownButtonFormField<String>(
//         decoration: InputDecoration(
//           labelText: widget.label,
//           border: const OutlineInputBorder(),
//           contentPadding: const EdgeInsets.all(8),
//         ),
//         items: authors.map((author) {
//           return DropdownMenuItem<String>(
//             value: author["id"],
//             child: Text(author["name"] ?? "Noma'lum"),
//           );
//         }).toList(),
//         onChanged: (newValue) {
//           setState(() {
//             selectedAuthor = newValue;
//             filerData.selectedAuthor = newValue;
//           });
//         },
//         value: selectedAuthor,
//       ),
//     );
//   }
// }
