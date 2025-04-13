import 'package:flutter/material.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/text_style.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType textInputType;
  final String prefixText;
  final bool isRequired;

  const MyTextField({
    super.key,
    required this.controller,
    required this.label,
    this.textInputType = TextInputType.text,
    this.prefixText = "",
    this.isRequired = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: TextFormField(
        validator: (value) {
          if (isRequired && (value == null || value.isEmpty)) {
            return "$label kiritilishi shart";
          }
          return null;
        },
        controller: controller,
        keyboardType: textInputType,
        textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.next,
        cursorColor: kBlack,
        decoration: InputDecoration(
          prefixText: prefixText.isNotEmpty ? prefixText : null,
          focusedBorder:
              const OutlineInputBorder(borderSide: BorderSide(color: kBlack)),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.all(8),
          labelText: isRequired ? "$label *" : label,
          labelStyle: kTSFS16,
          errorStyle: const TextStyle(
            color: Colors.red,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class MyTextFieldFilled extends StatelessWidget {
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

  const MyTextFieldFilled(
      {super.key,
      this.onChanged,
      required this.controller,
      required this.label,
      required this.textInputType,
      this.hint = "",
      this.next = TextInputAction.next,
      this.maxLines = 12,
      this.border = true,
      this.maxLens = false,
      this.text = ""});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: kTSFS16,
          ),
          SizedBox(
            height: 8,
          ),
          TextFormField(
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
                  borderSide: border
                      ? const BorderSide(color: kBlack)
                      : const BorderSide()),
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.all(8),
            ),
          ),
        ],
      ),
    );
  }
}
