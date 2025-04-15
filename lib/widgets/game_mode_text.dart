import 'package:flutter/material.dart';

TextStyle arcadeFont({
  double fontSize = 16,
  Color color = Colors.black,
  double letterSpacing = 3.0,
  FontWeight fontWeight = FontWeight.bold,
}) {
  return TextStyle(
    fontFamily: 'Arcade',
    fontSize: fontSize,
    color: color,
    letterSpacing: letterSpacing,
    fontWeight: fontWeight,
  );
}
