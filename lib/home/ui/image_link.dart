import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kitob_ol/image_upload.dart';

class ImageUploadScreen extends StatefulWidget {
  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  File? _image;
  final picker = ImagePicker();
  final ImageUpload imageUpload = ImageUpload();
  Future pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rasm Yuklash")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _image == null
              ? Text("Rasm tanlanmagan")
              : Image.file(_image!, height: 200),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => pickImage(ImageSource.gallery),
                child: Text("Galereyadan"),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => pickImage(ImageSource.camera),
                child: Text("Kamera"),
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => imageUpload.uploadImage(_image),
            child: Text("Yuklash"),
          ),
        ],
      ),
    );
  }
}
