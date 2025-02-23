import 'package:flutter/material.dart';

class DescriptionPage extends StatelessWidget {
  final String description;
  const DescriptionPage({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Description"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(description),
      ),
    );
  }
}
