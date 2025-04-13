import 'package:flutter/material.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/text_style.dart';

class MyTextFielNumber extends StatelessWidget {
  final void Function(String)? onChanged;
  final TextEditingController controller;
  final String label;
  final TextInputType textInputType;
  final String hint;
  final TextInputAction next;
  final bool border;
  final int? maxLines;
  final bool maxLens;
  final String text;

  const MyTextFielNumber(
      {super.key,
      this.onChanged,
      required this.controller,
      required this.label,
      required this.textInputType,
      this.hint = "",
      this.next = TextInputAction.next,
      this.maxLines,
      this.border = true,
      this.maxLens = false,
      this.text = ""});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      maxLength: maxLens ? maxLines : null,
      keyboardType: textInputType,
      textCapitalization: TextCapitalization.none,
      textInputAction: next,
      cursorColor: kBlack,
      decoration: InputDecoration(
        counterText: "",
        hintText: text,
        icon: Text(
          hint,
          style: kTSFW,
        ),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)),
        filled: true,
        fillColor: const Color(0xffeaeaeb),
        focusedBorder: OutlineInputBorder(
            borderSide:
                border ? const BorderSide(color: kBlack) : const BorderSide()),
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.all(8),
      ),
    );
  }
}
