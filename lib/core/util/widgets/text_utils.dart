import 'package:flutter/material.dart';

class TextUtils extends StatelessWidget {
  final String textContent;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final TextDecoration decoration;

  const TextUtils(
      {Key? key,
      required this.textContent,
      required this.fontSize,
      required this.color,
      required this.fontWeight,
      this.decoration = TextDecoration.none})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      textContent,
      style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
          decoration: decoration),
    );
  }
}
