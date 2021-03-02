import 'package:flutter/material.dart';
import 'package:swipe_app/basicThings/basic.dart';

class InputField extends StatefulWidget {
  final TextEditingController _controller;
  final String _hint;
  InputField(this._controller, this._hint);
  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      //height: double.minPositive,
      alignment: Alignment.centerLeft,
      child: TextField(
        controller: widget._controller,
        obscureText: false,
        keyboardType: TextInputType.text,//TextInputType.number,
        style: RegularText(14, Color(0xff737373)),
        decoration: InputDecoration(
          //contentPadding: EdgeInsets.all(12),
          isCollapsed: true,
          hintStyle: RegularText(14, Color(0xff737373)),//TextStyle(fontFamily: 'Montserrat', color: Colors.white, fontSize: 16, ),
          hintText: widget._hint,
          //focusedBorder: OutlineInputBorder(
          //borderRadius: BorderRadius.circular(10),
          //borderSide: BorderSide(color: borderColor, width: 1),//Color(0xff56C385)
          //),
        ),
      ),
    );
  }
}
