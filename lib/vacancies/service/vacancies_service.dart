import 'dart:convert';
import 'package:http/http.dart' as http;

class VacancyService {
  static const String _baseUrl =
      'https://gateway.axadjonovsardorbek.uz/vacancies/list';

  Future<List<dynamic>> fetchVacancies() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['vacancies'] ?? [];
      } else {
        throw Exception('Failed to load vacancies: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching vacancies: $e');
    }
  }
}
