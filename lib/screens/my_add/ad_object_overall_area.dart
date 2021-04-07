import 'package:flutter/material.dart';
import 'package:swipe_app/global/style/text_styles.dart';
import 'package:swipe_app/models/add_model.dart';
import 'package:swipe_app/screens/my_add/input_field.dart';

class OverallArea extends StatefulWidget {
  final Add _add;
  OverallArea(this._add);
  @override
  _OverallAreaState createState() => _OverallAreaState();
}

class _OverallAreaState extends State<OverallArea> {
  TextEditingController _inputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String hint = "М\u{00B2}";
    if(widget._add.overallArea != null ){
      //widget._add.overallArea = widget._add.overallArea + hint;
      hint = widget._add.overallArea;
    }
    return   Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Общая площадь", style: SemiBoldText(14, Color(0xff2E2E2E))),
          SizedBox(height: 10),
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(vertical: 13, horizontal: 12),
            decoration: BoxDecoration(
                color: Color(0x20DADADA),
                borderRadius: BorderRadius.circular(10)
            ),
            //child: Text("current adress",style: RegularText(14, Color(0xff737373)),),
           // child: InputField(widget._concreteAd, "setOverallArea", _inputController, "М\u{00B2}",1),
            child: InputField(widget._add, "setOverallArea", _inputController, hint,1),
          ),
        ],
      ),
    );
  }
}
