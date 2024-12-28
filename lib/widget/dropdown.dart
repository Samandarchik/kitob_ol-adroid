import 'package:flutter/material.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/text_style.dart';

class MyDropdown extends StatelessWidget {
  final List<String> items;
  final String label;
  const MyDropdown({super.key, required this.items, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
            labelText: label,
            focusedBorder:
                const OutlineInputBorder(borderSide: BorderSide(color: kBlack)),
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.all(8),
            labelStyle: kTSFS16,
            fillColor: kWhite),
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (_) {},
      ),
    );
  }
}
