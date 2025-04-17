import 'package:flutter/material.dart';

class GetColor {
  Color backgrouColor = Color(0xFFDBFCE4);
  Color buttonColor = Color(0xFf1E8352);
}

class GetSize {
  double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
