import 'package:flutter/material.dart';

Widget buildText(String content,
  {
double fontSize = 10,
Color fontColor = Colors.white,
FontWeight fontWeight = FontWeight.bold,
TextAlign alignment = TextAlign.center,
FontStyle fontStyle = FontStyle.normal,
  }) {
    return Text(
      content,
      textAlign: alignment,
      style: TextStyle(
        fontSize: fontSize,
        color: fontColor,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
      ),
    );
  }

  