import 'dart:async';

import 'package:flutter/material.dart';
import 'package:swipe_app/global/style/text_styles.dart';


class InputChat extends StatefulWidget {

  final TextEditingController _controller;
  final ScrollController _scrollController;
  final String _hint;
  InputChat(this._controller, this._scrollController, this._hint);
  @override
  _InputChatState createState() => _InputChatState();
}

class _InputChatState extends State<InputChat> {
  FocusNode _focus = new FocusNode();
  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  void _onFocusChange(){
    debugPrint("Focus: "+_focus.hasFocus.toString());
    if(_focus.hasFocus)
    Timer(Duration(milliseconds: 2000), () => widget._scrollController
        .jumpTo(widget._scrollController.position.maxScrollExtent));
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 36,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 9.5),
      child: TextField(
        focusNode: _focus,
      /*  onEditingComplete:()=> Timer(Duration(milliseconds: 100), () => widget._scrollController
            .jumpTo(widget._scrollController.position.maxScrollExtent)),
        onChanged: (value) => Timer(Duration(milliseconds: 100), () => widget._scrollController
            .jumpTo(widget._scrollController.position.maxScrollExtent)),
        onSubmitted:(value) => Timer(Duration(milliseconds: 100), () => widget._scrollController
            .jumpTo(widget._scrollController.position.maxScrollExtent)),*/
        onTap: ()=>  Timer(Duration(milliseconds: 100), () => widget._scrollController
            .jumpTo(widget._scrollController.position.maxScrollExtent)),
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