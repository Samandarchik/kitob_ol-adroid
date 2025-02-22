import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kitob_ol/home/service/ish.dart';

class IshService {
  final String apiUrl = "https://gateway.axadjonovsardorbek.uz/vacancies/list";

  /// Replace with your API URL

  Future<List<Ish>> fetchIshs() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // Map the JSON response to Book objects
      List<Ish> ish = [];
      for (var bookJson in data['vacancies']) {
        ish.add(Ish.fromJson(bookJson));
      }
      return ish;
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<String> getIsh(String id) async {
    //https://gateway.axadjonovsardorbek.uz/vacancies/get?id=12
    final String url =
        "https://gateway.axadjonovsardorbek.uz/vacancies/get?id=$id";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data['view_count'].toString();
    } else {
      throw Exception('Failed to load books');
    }
  }
}
