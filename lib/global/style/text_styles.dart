import 'package:flutter/material.dart';

  TextStyle SemiBoldText(double fontSize, Color color) {
    return TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold,
        color: color, fontSize: fontSize);
  }

  TextStyle RegularText(double fontSize, Color color) {
    return TextStyle(fontFamily: 'Montserrat', color: color, fontSize: fontSize);
  }

  TextStyle MediumText(double fontSize, Color color) {
    return TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w500, color: color, fontSize: fontSize);
  }
