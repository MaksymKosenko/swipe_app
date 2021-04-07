import 'package:flutter/material.dart';
import 'package:swipe_app/global/style/text_styles.dart';
import 'package:swipe_app/models/add_model.dart';

class InputField extends StatefulWidget {
  final Add _add;
  final String _dataForSet;
  final TextEditingController _controller;
  final String _hint;
  final int _maxLines;
  InputField(this._add, this._dataForSet, this._controller, this._hint, this._maxLines);
  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  setData(String data){
    setState(() {
      switch(data){
        case "setOverallArea": widget._add.overallArea = widget._controller.text; break;
        case "setKitchenArea": widget._add.kitchenArea = widget._controller.text; break;
        case "setDescription": widget._add.description = widget._controller.text; break;
        case "setCost": widget._add.cost = widget._controller.text; break;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      //height: double.minPositive,
      alignment: Alignment.centerLeft,
      child: TextField(
        onEditingComplete:()=> setData(widget._dataForSet),
        onChanged: (value) => setData(widget._dataForSet),
        onSubmitted:(value) => setData(widget._dataForSet),
        maxLines: widget._maxLines,
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
