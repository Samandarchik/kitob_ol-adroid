import 'package:flutter/material.dart';
import 'package:kitob_ol/text_style.dart';

class DetailsInfo extends StatelessWidget {
  final String description;
  const DetailsInfo({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Text("Qo'shimcha malumot"),
      ),
      body: Column(
        children: [
          Divider(),
          Text(
            description,
            style: kTSFWB18,
          )
        ],
      ),
    );
  }
}
