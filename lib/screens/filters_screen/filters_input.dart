import 'package:flutter/material.dart';
import 'package:swipe_app/global/style/text_styles.dart';
import 'package:swipe_app/models/filters_model.dart';

class FiltersInput extends StatefulWidget {
  final Filter _filter;
  final TextEditingController _controller;
  final String _hint;
  FiltersInput(this._filter, this._controller, this._hint);
  @override
  _FiltersInputState createState() => _FiltersInputState();
}

class _FiltersInputState extends State<FiltersInput> {
  setData(String hint){
    setState(() {
      switch(hint){
        case "От 20 000₴": widget._filter.priceLow = widget._controller.text; break;
        case "До 50 000₴": widget._filter.priceHigh = widget._controller.text; break;
        case "От 70М\u{00B2}": widget._filter.overallAreaLow = widget._controller.text; break;
        case "До 120М\u{00B2}": widget._filter.overallAreaHigh = widget._controller.text; break;
        case "От 20М\u{00B2}": widget._filter.kitchenAreaLow = widget._controller.text; break;
        case "До 50М\u{00B2}": widget._filter.kitchenAreaHigh = widget._controller.text; break;
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
        onEditingComplete:()=> setData(widget._hint),
        onChanged: (value) => setData(widget._hint),
        onSubmitted:(value) => setData(widget._hint),
        maxLines: 1,
        controller: widget._controller,
        obscureText: false,
        keyboardType: TextInputType.text,//TextInputType.number,
        style:  RegularText(14, Color(0xff737373)),
        decoration: InputDecoration(
          //contentPadding: EdgeInsets.all(12),
          isCollapsed: true,
          hintStyle: RegularText(14, Color(0xff737373)),//TextStyle(fontFamily: 'Montserrat', color: Colors.white, fontSize: 16, ),
          hintText: widget._hint,
          /*focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xff56C385), width: 1),//Color(0xff56C385)
          ),*/
        ),
      ),
    );
  }
}
