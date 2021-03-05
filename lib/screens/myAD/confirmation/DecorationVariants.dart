import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_app/basicThings/basic.dart';

class DecorationVariant extends StatefulWidget {
  final String text;
  final Color color;
  const DecorationVariant({
    Key key,
    @required this.text, this.color
  }) : super(key: key);

  @override
  _DecorationVariantState createState() => _DecorationVariantState();
}

class _DecorationVariantState extends State<DecorationVariant> {
  bool status = false;//widget.activeStatus;
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 13),
        height: 44,
        decoration: BoxDecoration(
            color: Color(0xffF8F8F8),
            borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.text, style: RegularText(14, Color(0xff737373)),),
            Container(width: 15, height: 15, decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: widget.color),)
          ],
        ),
      ),
    );
  }
}

