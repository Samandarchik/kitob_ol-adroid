import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kitob_ol/home/model/book_model_favorite.dart';
import 'package:kitob_ol/home/model/job_model.dart';
import 'package:kitob_ol/provider_auth.dart';
import 'package:provider/provider.dart';

class ApiServiceFavorites {
  static const String url =
      "https://gateway.axadjonovsardorbek.uz/favourites/list";
  Future<Map<String, dynamic>> fetchData(BuildContext context) async {
    final response = await http.get(Uri.parse(url), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer ${AuthService().getToken()}",
    });
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      List<BookModelFavorite> books = [];
      List<JobModel> jobs = [];

      for (var item in data['boooks']) {
        if (item['book_id'] != "undefined") {
          books.add(BookModelFavorite.fromJson(item));
        } else {
          jobs.add(JobModel.fromJson(item));
        }
      }

      return {"books": books, "jobs": jobs};
    } else {
      throw Exception('Ma\'lumot yuklanmadi');
    }
  }
}
