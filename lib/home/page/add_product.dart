import 'package:flutter/material.dart';
import 'package:kitob_ol/widget/my_text_field.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  late final TextEditingController bookName;
  late final TextEditingController categoriya;
  @override
  void initState() {
    super.initState();
    bookName = TextEditingController();
    categoriya = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    bookName.dispose();
    categoriya.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bizga e'loningiz haqida gapirib bering"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            MyTextFieldFilled(
                controller: bookName,
                label: "label",
                textInputType: TextInputType.text)
          ],
        ),
      ),
    );
  }
}
