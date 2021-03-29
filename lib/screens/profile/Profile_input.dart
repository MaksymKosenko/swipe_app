import 'package:flutter/material.dart';
import 'package:swipe_app/global/style/text_styles.dart';

Widget ProfileInput(String hint, TextEditingController controller, bool obscure) {
  if(hint == "null")
    hint = "нет данных";
  return Container(
    height: 44,
    //width: 400,//253
    alignment: Alignment.centerLeft,
    decoration: BoxDecoration(
      color: Color(0x32DADADA),
      borderRadius: BorderRadius.circular(10),
    ),
    child: TextField(
      controller: controller,
      obscureText: obscure,
      style: RegularText(14,Color(0xff737373)),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(12),
        isCollapsed: true,
        hintStyle: RegularText(14,Color(0xff737373)),
        hintText: hint,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xff737373), width: 1),
        ),
      ),
    ),
  );
}
