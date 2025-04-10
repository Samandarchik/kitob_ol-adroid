import 'package:flutter/material.dart';
import 'package:kitob_ol/color.dart';

class MyBottonText extends StatelessWidget {
  final double bottom;
  final String text;
  final Color boxColor;
  final Color textColor;
  final void Function()? onTap;
  final double width;
  final double top;
  final void Function()? onLongPress;

  const MyBottonText(
      {super.key,
      required this.text,
      required this.boxColor,
      required this.textColor,
      required this.onTap,
      this.top = 0,
      this.width = double.infinity,
      this.onLongPress,
      this.bottom = 0});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: Padding(
        padding: EdgeInsets.only(top: top),
        child: GestureDetector(
          onLongPress: onLongPress,
          child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: boxColor,
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(2)),
              minimumSize: Size(width, 50),
            ),
            child: Text(
              text,
              style: TextStyle(
                  color: textColor, fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}

class MyElevedButtonBorder extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final double width;
  const MyElevedButtonBorder(
      {super.key,
      required this.onTap,
      required this.text,
      this.width = double.infinity});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: kWhite,
        side: const BorderSide(color: Colors.black),
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(2)),
        minimumSize: Size(width, 50),
      ),
      child: Text(
        text,
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
      ),
    );
  }
}
