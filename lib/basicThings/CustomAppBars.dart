import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_app/basicThings/basic.dart';

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String title;
  final double fromTextToIconWidth;
  final MaterialPageRoute backScreen;
  const MyCustomAppBar({
    Key key,
    @required this.title, this.height, this.fromTextToIconWidth,this.backScreen
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(height: 44),
        Container(
          height: 60,
          color: Color(0xffF5F5F5),
          child: Row(
            children: [
              SizedBox(width: 10),
              IconButton(icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.black), padding: EdgeInsets.all(0), iconSize: 24,
                  onPressed: ()=> Navigator.push(context, backScreen)),
              SizedBox(width: 10),
              Text(title , style: RegularText(20, Color(0xff2E2E2E)),),
              SizedBox(width: fromTextToIconWidth),
              IconButton(icon: Icon(CupertinoIcons.xmark_circle, size: 30, color: Color(0xffEB5757),),
                  onPressed: ()=> Navigator.push(context, backScreen))
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}