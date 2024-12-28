import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfoScreen extends StatefulWidget {
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  String? _firstName, _lastName, _age;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  // Saqlangan ma'lumotlarni yuklash
  _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _firstName = prefs.getString('firstName');
      _lastName = prefs.getString('lastName');
      _age = prefs.getString('age');
    });
  }

  // Foydalanuvchi ma'lumotlarini saqlash
  saveUserInfo(String firstName, String lastName, String age) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('firstName', firstName);
    await prefs.setString('lastName', lastName);
    await prefs.setString('age', age);
  }

  // Foydalanuvchi ma'lumotlarini olish
  Future<Map<String, String?>> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'firstName': prefs.getString('firstName'),
      'lastName': prefs.getString('lastName'),
      'age': prefs.getString('age'),
    };
  }

  // Ma'lumotlarni o'chirish
  removeUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('firstName');
    await prefs.remove('lastName');
    await prefs.remove('age');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SharedPreferences Example")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Ism: ${_firstName ?? 'No name'}"),
            Text("Familiya: ${_lastName ?? 'No last name'}"),
            Text("Yosh: ${_age ?? 'No age'}"),
            SizedBox(height: 20),

            // Ism kiritish
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(labelText: 'Ismingizni kiriting'),
            ),
            SizedBox(height: 10),

            // Familiya kiritish
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(labelText: 'Familiyangizni kiriting'),
            ),
            SizedBox(height: 10),

            // Yosh kiritish
            TextField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Yoshingizni kiriting'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),

            // Saqlash va tozalash tugmalari
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    saveUserInfo(
                      _firstNameController.text,
                      _lastNameController.text,
                      _ageController.text,
                    );
                    _loadUserInfo(); // Ma'lumotlarni yangilash
                  },
                  child: Text("Saqlash"),
                ),
                ElevatedButton(
                  onPressed: () {
                    removeUserInfo();
                    setState(() {
                      _firstName = null;
                      _lastName = null;
                      _age = null;
                    });
                  },
                  child: Text("Tozalash"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
