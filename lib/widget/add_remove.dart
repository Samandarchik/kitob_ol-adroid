import 'package:dio/dio.dart';
import 'package:kitob_ol/core/di/di.dart';

Future<void> addRemove(
  String id,
  bool isAdd,
) async {
  Dio dio = sl<Dio>();
  try {
    print("object");
    isAdd
        ? await dio.delete(
            'https://gateway.axadjonovsardorbek.uz/favourites/delete',
            data: {
              "book_id": id,
            },
          )
        : await dio.post(
            'https://gateway.axadjonovsardorbek.uz/favourites/create',
            data: {
              "book_id": id,
            },
          );

    print("Success${isAdd ? "Add" : "Remove"}");
  } catch (e) {
    print(e);
  }
}

Future<bool> addRemoveVac(
  String id,
  bool isAdd,
) async {
  Dio dio = sl<Dio>();
  try {
    print("object $id");
    isAdd
        ? await dio.delete(
            'https://gateway.axadjonovsardorbek.uz/favourites/delete',
            data: {
              "vacancy_id": id,
            },
          )
        : await dio.post(
            'https://gateway.axadjonovsardorbek.uz/favourites/create',
            data: {
              "vacancy_id": id,
            },
          );
    print("Success${isAdd ? "Add" : "Remove"}");
    return true;
  } catch (e) {
    return false;
  }
}
