import 'package:flutter/material.dart';
import 'package:swipe_app/global/style/gradients.dart';

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