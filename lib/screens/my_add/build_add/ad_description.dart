import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:swipe_app/global/style/text_styles.dart';
import 'package:swipe_app/models/add_model.dart';

import 'package:swipe_app/screens/my_add/input_field.dart';

class Description extends StatefulWidget {
  final Add _add;
  Description(this._add);
  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  TextEditingController _inputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String hint = "Описание вашей недвижимости";
    if(widget._add.description != null )
      hint = widget._add.description;
    return   Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Описание", style: SemiBoldText(14, Color(0xff2E2E2E))),
          SizedBox(height: 10),
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(vertical: 13, horizontal: 12),
            decoration: BoxDecoration(
                color: Color(0x20DADADA),
                borderRadius: BorderRadius.circular(10)
            ),
            //child: Text("current adress",style: RegularText(14, Color(0xff737373)),),
            child: InputField(widget._add, "setDescription", _inputController, hint ,10),
          ),
        ],
      ),
    );
  }
}
