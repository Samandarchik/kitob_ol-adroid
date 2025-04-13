import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kitob_ol/color.dart';
import 'package:kitob_ol/text_style.dart';

class DateOfBirthField extends StatefulWidget {
  final TextEditingController dateController;
  const DateOfBirthField({super.key, required this.dateController});

  @override
  State<DateOfBirthField> createState() => _DateOfBirthFieldState();
}

class _DateOfBirthFieldState extends State<DateOfBirthField> {
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: 'Tug‘ilgan kunni tanlang',
      cancelText: 'Bekor qilish',
      confirmText: 'Tanlash',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: kBlack, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: kBlack, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        widget.dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Tug'ilgan kun kiritilishi shart";
        }
        return null;
      },
      controller: widget.dateController,
      readOnly: true,
      onTap: () => _selectDate(context),
      decoration: InputDecoration(
        labelText: "Tug'ilgan kun",
        labelStyle: kTSFS16,
        hintText: "YYYY-MM-DD",
        prefixIcon: const Icon(Icons.calendar_today),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kBlack),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      ),
    );
  }
}
