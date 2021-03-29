import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  double _size;
  double _logoWidth;
  double _logoHeight;
  double _spacing;

  Logo(double fontSize, double logoWidth, double logoHeight, double spacing) {
    this._size = fontSize;
    this._logoWidth = logoWidth;
    this._logoHeight = logoHeight;
    this._spacing = spacing;
  }

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/Group30.png',
            width: _logoWidth, height: _logoHeight),
        SizedBox(width: _spacing),
        Text(
          "cвайп",
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w900,
            color: Colors.white,
            fontSize: _size,
          ),
        ),
      ],
    );
  }
}




