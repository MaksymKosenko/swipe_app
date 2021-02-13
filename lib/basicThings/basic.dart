import 'package:flutter/material.dart';
import 'package:swipe_app/screens/ProfileScreen.dart';

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
        Image.asset('lib/assets/images/Group30.png',
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

BoxDecoration GradientBack() {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xff0B3138), Color(0xff0A4A46)],
    ),
  );
}

BoxDecoration GradientInputBack() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [Color(0x3327AE63), Color(0x3327AE9E)],
    ),
  );
}

TextStyle SemiBoldText(double fontSize) {
  return TextStyle(
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: fontSize);
}

TextStyle RegularText(double fontSize, Color color) {
  return TextStyle(fontFamily: 'Montserrat', color: color, fontSize: fontSize);
}

TextStyle MediumText(double fontSize, Color color) {
  return TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w500, color: color, fontSize: fontSize);
}

Widget CustomButton(
  double _width,
  double _height,
  double _borderRadiusCircular,
  Color _color1,
  Color _color2,
  Alignment _beginGradient,
  Alignment _endGradient,
  String _text,
  TextStyle _style,
  Color _borderColor,
) {
  return Container(
    height: _height,
    width: _width,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(_borderRadiusCircular),
      border: Border.all(color: _borderColor),
      gradient: LinearGradient(
        begin: _beginGradient,
        end: _endGradient,
        colors: [_color1, _color2],//[Color(0xff56C385), Color(0xff41BFB5)],
      ),
    ),
    child: Text("$_text", style: _style),
  );
}

Widget input(double width, double height, TextEditingController controller, bool obscure,TextInputType inputType,
    TextStyle textStyle, TextStyle hintStyle,String hint, Color borderColor) {
  return Container(
    height: height,
    width: width,
    alignment: Alignment.centerLeft,
    decoration: GradientInputBack(),
    child: TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: inputType,//TextInputType.number,
      style: textStyle,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(12),
        isCollapsed: true,
        hintStyle: hintStyle,//TextStyle(fontFamily: 'Montserrat', color: Colors.white, fontSize: 16, ),
        hintText: hint,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: borderColor, width: 1),//Color(0xff56C385)
        ),
      ),
    ),
  );
}

