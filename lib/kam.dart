import 'package:flutter/material.dart';
import 'package:kitob_ol/color.dart';

class CustomDropdown extends StatefulWidget {
  final String label;
  final List<Map<String, dynamic>> items;
  final Function(String?) onChanged;
  final TextEditingController controller;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.items,
    required this.onChanged,
    required this.controller,
  });

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.items.isNotEmpty ? widget.items.first["id"] : null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        dropdownColor: kWhite,
        decoration: InputDecoration(
          labelText: widget.label,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(5),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
        icon: Icon(Icons.arrow_drop_down, color: kBlack),
        items: widget.items.map((item) {
          return DropdownMenuItem<String>(
            value: item["id"],
            child: Text(item["name"] ?? "Noma'lum"),
          );
        }).toList(),
        onChanged: (newValue) {
          if (newValue == null) return;

          setState(() {
            selectedValue = newValue;

            try {
              String name =
                  widget.items.firstWhere((e) => e["id"] == newValue)["name"] ??
                      "Noma'lum";
              widget.controller.text = name;
            } catch (e) {
              widget.controller.text = "Noma'lum";
            }

            widget.onChanged(newValue);
          });
        },
        value: selectedValue,
      ),
    );
  }
}
