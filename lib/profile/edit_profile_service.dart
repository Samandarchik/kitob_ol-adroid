import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:kitob_ol/core/di/di.dart';
import 'package:kitob_ol/home/model/user_info_model.dart';
import 'package:kitob_ol/profile/profile.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class EditProfileService {
  final Dio dio = sl<Dio>();

//  import 'dart:io';
// import 'package:image/image.dart' as img;
// import 'package:dio/dio.dart';

  Future<String?> uploadImage(File imageFile) async {
    try {
      final int sizeInBytes = await imageFile.length();
      const maxSize = 989042; // 989042 bytes (yakuniy o'lcham)

      File resizedFile = imageFile;

      if (sizeInBytes > maxSize) {
        print("Image too large, resizing...");

        // Rasmni o'qish va kichraytirish
        final originalBytes = await imageFile.readAsBytes();
        final originalImage = img.decodeImage(originalBytes);

        if (originalImage == null) return null;

        // Rasmning o'lchamini kesish va sifatini sozlash
        final double scaleFactor = (maxSize / sizeInBytes).toDouble();
        final newWidth = (originalImage.width * scaleFactor).toInt();
        final newHeight = (originalImage.height * scaleFactor).toInt();

        // Kichraytirilgan rasmni yaratish
        final resizedImage = img.copyResize(
          originalImage,
          width: newWidth,
          height: newHeight,
        );

        // Rasmni yangi formatda kodlash va diskda saqlash
        final resizedBytes = img.encodeJpg(resizedImage, quality: 85);
        final tempDir = await getTemporaryDirectory();
        resizedFile = await File('${tempDir.path}/resized_image.jpg')
            .writeAsBytes(resizedBytes);

        print("Rasm ulchami: ${resizedFile.lengthSync()} bytes");
      }

      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(resizedFile.path),
      });

      final response = await dio.post(
        'https://gateway.axadjonovsardorbek.uz/img-upload',
        data: formData,
      );

      if (response.statusCode == 200) {
        return response.data['Url'];
      } else {
        print("Upload failed: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

  Future<void> editProfile(
      UserDataModel userDataModel, BuildContext context) async {
    try {
      final response = await dio.put(
        'https://auth.axadjonovsardorbek.uz/auth/user/update',
        data: {
          "first_name": userDataModel.name,
          "last_name": userDataModel.lastName,
          if (userDataModel.imageUrl != null)
            "image_url": userDataModel.imageUrl,
          "phone_number": userDataModel.number,
          "email": userDataModel.email,
          "date_of_birth": userDataModel.birthday,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyProfile()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("${response.data}, ${response.statusCode}"),
        ));
      }
    } catch (e) {}
  }
}
