import 'package:flutter/material.dart';

TextSpan textSpan({
    String label,
    Color color = Colors.black87,
    String data,
  }) {
    return TextSpan(
        text: label,
        style: TextStyle(
            color: color,
            fontSize: 18,
            fontFamily: 'vazir',
            fontWeight: FontWeight.bold),
        children: [
          TextSpan(
            text: data,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
          )
        ]);
  }