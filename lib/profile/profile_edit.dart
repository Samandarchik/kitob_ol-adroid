import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/home/model/user_info_model.dart';
import 'package:kitob_ol/profile/edit_profile_service.dart';
import 'package:kitob_ol/profile/texteti_bri.dart';
import 'package:kitob_ol/widget/my_botton_text.dart';
import 'package:kitob_ol/widget/my_text_field.dart';

class MyProfileEdit extends StatefulWidget {
  final UserDataModel user;
  const MyProfileEdit({
    super.key,
    required this.user,
  });

  @override
  State<MyProfileEdit> createState() => _MyProfileEditState();
}

class _MyProfileEditState extends State<MyProfileEdit> {
  late final TextEditingController name;
  late final TextEditingController lastName;
  late final TextEditingController birthday;
  late final TextEditingController phoneNumber;
  late final TextEditingController email;
  final EditProfileService editProfileService = EditProfileService();
  File? pickedImage;

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.user.name);
    lastName = TextEditingController(text: widget.user.lastName);
    birthday = TextEditingController(text: widget.user.birthday);
    phoneNumber = TextEditingController(text: widget.user.number);
    email = TextEditingController(text: widget.user.email);
  }

  @override
  void dispose() {
    name.dispose();
    lastName.dispose();
    birthday.dispose();
    phoneNumber.dispose();
    email.dispose();
    pickedImage = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "profile".tr(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * .072,
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    SizedBox(height: 20),
                    Center(
                      child: Stack(
                        children: [
                          SizedBox(
                            height: size.height * 0.25,
                            width: size.height * 0.25,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: pickedImage != null
                                  ? FileImage(pickedImage!)
                                  : NetworkImage(widget.user.imageUrl ??
                                          'https://i.pinimg.com/736x/03/eb/d6/03ebd625cc0b9d636256ecc44c0ea324.jpg')
                                      as ImageProvider,
                              backgroundColor: Colors.grey[200],
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: GestureDetector(
                              onTap: _pickImage,
                              child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.white, width: 3),
                                    color: Colors.black,
                                  ),
                                  child: SvgPicture.asset(
                                    "assets/icon/Gallery Edit.svg",
                                    width: MediaQuery.of(context).size.width *
                                        .045,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    MyTextField(
                      controller: name,
                      label: "name".tr(),
                      textInputType: TextInputType.text,
                    ),
                    MyTextField(
                      controller: lastName,
                      label: "surname".tr(),
                      textInputType: TextInputType.text,
                    ),
                    SizedBox(height: 15),
                    DateOfBirthField(
                      dateController: birthday,
                    ),
                    MyTextField(
                      controller: phoneNumber,
                      label: "phoneNumber".tr(),
                      textInputType: TextInputType.phone,
                    ),
                    MyTextField(
                      controller: email,
                      label: "email".tr(),
                      textInputType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyElevedButtonBorder(
                    width: size.width * .45,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    text: "pascancel".tr(),
                  ),
                  MyBottonText(
                    width: size.width * .45,
                    text: "paseSave".tr(),
                    boxColor: imageColor,
                    textColor: kWhite,
                    onTap: () => showDia(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        pickedImage = File(pickedFile.path);
      });
    }
  }

  void showDia(BuildContext context) => showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("onTapEdit".tr()),
          actions: [
            GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Text("${"no".tr()}  ")),
            SizedBox(width: 10),
            GestureDetector(
                onTap: () async {
                  if (pickedImage != null) {
                    String? imageUrl1 =
                        await editProfileService.uploadImage(pickedImage!);
                    if (imageUrl1 != null) {
                      editProfileService.editProfile(
                          UserDataModel(
                            name: name.text,
                            lastName: lastName.text,
                            birthday: birthday.text,
                            number: phoneNumber.text,
                            email: email.text,
                          ),
                          context);
                    }
                  }
                  await editProfileService.editProfile(
                      UserDataModel(
                        name: name.text,
                        lastName: lastName.text,
                        birthday: birthday.text,
                        number: phoneNumber.text,
                        email: email.text,
                      ),
                      context);
                },
                child: Text("${"yes".tr()}  ")),
          ],
        );
      });
}
