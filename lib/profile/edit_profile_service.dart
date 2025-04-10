import 'package:image/image.dart' as img;
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:kitob_ol/core/di/di.dart';
import 'package:kitob_ol/home/model/user_info_model.dart';

class EditProfileService {
  final Dio dio = sl<Dio>();

//  import 'dart:io';
// import 'package:image/image.dart' as img;
// import 'package:dio/dio.dart';

  Future<String?> uploadImage(File imageFile) async {
    try {
      final int sizeInBytes = await imageFile.length();
      const maxSize = 2 * 1024 * 1024; // 2MB

      File resizedFile = imageFile;

      if (sizeInBytes > maxSize) {
        print("Image too large, resizing...");

        // Rasmni o'qish va kichraytirish
        final originalBytes = await imageFile.readAsBytes();
        final originalImage = img.decodeImage(originalBytes);

        if (originalImage == null) return null;

        final resizedImage = img.copyResize(
          originalImage,
          width: (originalImage.width * 0.5).toInt(), // 50% ga kichraytirish
        );

        final resizedBytes = img.encodeJpg(resizedImage, quality: 85);
        final tempDir = Directory.systemTemp;
        resizedFile = await File('${tempDir.path}/resized_image.jpg')
            .writeAsBytes(resizedBytes);
      }

      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(resizedFile.path),
      });

      final response = await Dio().post(
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

  Future<UserDataModel?> editProfile(final UserDataModel userDataModel) async {
    try {
      final response = await dio.put(
        'https://auth.axadjonovsardorbek.uz/auth/user/update',
        data: {
          "first_name": userDataModel.name,
          "last_name": userDataModel.lastName,
          "image_url": userDataModel.imageUrl,
          "phone_number": userDataModel.number,
          "email": userDataModel.email,
          "date_of_birth": userDataModel.birthday,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return userDataModel;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
