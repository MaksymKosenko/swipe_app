import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_app/global/style/text_styles.dart';

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
 /*final double height;
  final String title;
  final MaterialPageRoute backScreen;
  const MyCustomAppBar({Key key, @required this.title, this.height, this.backScreen}) : super(key: key);*/
  final double _height;
  final String _title;
  final MaterialPageRoute _backScreen;
  const MyCustomAppBar(this._title, this._height, this._backScreen);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      child: Column(
        children: [
          Container(height: 22, color: Colors.white,), //for ios - 44
          Container(
            height: 60,
            color: Color(0xffF5F5F5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.black),padding: EdgeInsets.symmetric(horizontal: 10),
                        onPressed: ()=> Navigator.push(context, _backScreen)),
                    Text(_title , style: RegularText(20, Color(0xff2E2E2E)),),
                  ],
                ),
                IconButton(icon: Icon(CupertinoIcons.xmark_circle, size: 30, color: Color(0xffEB5757),), padding: EdgeInsets.only(right: 20),
                    onPressed: ()=> Navigator.push(context, _backScreen))
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_height);
}