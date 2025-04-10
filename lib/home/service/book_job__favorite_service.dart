import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kitob_ol/core/data/local/token_storage.dart';
import 'package:kitob_ol/core/di/di.dart';
import 'package:kitob_ol/home/model/book_model_favorite.dart';
import 'package:kitob_ol/home/model/job_model.dart';

class ApiServiceFavorites {
  final TokenStorage tokenStorage = sl<TokenStorage>();
  final Dio dio = sl<Dio>();
  static const String url =
      "https://gateway.axadjonovsardorbek.uz/favourites/list";
  Future<Map<String, dynamic>> fetchData(BuildContext context) async {
    print("dio favorite");
    final response = await dio.get(
      "https://gateway.axadjonovsardorbek.uz/favourites/list",
    );
    if (response.statusCode == 200) {
      final data = response.data;

      List<BookModelFavorite> books = [];
      List<JobModel> jobs = [];
      print(response.data);
      print(response.statusCode);

      for (var item in data['boooks']) {
        if (item['book_id'] != "undefined") {
          books.add(BookModelFavorite.fromJson(item, context));
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
