import 'package:flutter/material.dart';
import 'package:swipe_app/global/style/text_styles.dart';


class InputChat extends StatefulWidget {

  final TextEditingController _controller;
  final String _hint;
  InputChat(this._controller, this._hint);
  @override
  _InputChatState createState() => _InputChatState();
}

class _InputChatState extends State<InputChat> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 36,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 9.5),
      child: TextField(
        //onEditingComplete:()=> setData(widget._dataForSet),
        //onChanged: (value) => setData(widget._dataForSet),
        //onSubmitted:(value) => setData(widget._dataForSet),
        maxLines: 3,
        controller: widget._controller,
        obscureText: false,
        keyboardType: TextInputType.text,//TextInputType.number,
        style:  RegularText(14, Color(0xff737373)),
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