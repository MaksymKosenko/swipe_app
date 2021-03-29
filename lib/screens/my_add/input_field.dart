import 'package:flutter/material.dart';
import 'package:swipe_app/global/style/text_styles.dart';
import 'package:swipe_app/screens/my_add/confirmation/ad_model.dart';

class InputField extends StatefulWidget {
  final ConcreteAd _concreteAd;
  final String _dataForSet;
  final TextEditingController _controller;
  final String _hint;
  final int _maxLines;
  InputField(this._concreteAd, this._dataForSet, this._controller, this._hint, this._maxLines);
  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  setData(String data){
    setState(() {
      switch(data){
        case "setOverallArea": widget._concreteAd.setOverallArea(widget._controller.text); break;
        case "setKitchenArea": widget._concreteAd.setKitchenArea(widget._controller.text); break;
        case "setDescription": widget._concreteAd.setDescription(widget._controller.text); break;
        case "setCost": widget._concreteAd.setCost(widget._controller.text); break;
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
        onChanged: setData(widget._dataForSet),
        onSubmitted: setData(widget._dataForSet),

        maxLines: widget._maxLines,
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
