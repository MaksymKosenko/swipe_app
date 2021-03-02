import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_app/basicThings/basic.dart';

class ADPhotos extends StatefulWidget {
  @override
  _ADPhotosState createState() => _ADPhotosState();
}

class _ADPhotosState extends State<ADPhotos> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Text("Главное фото", style: RegularText(12, Color(0xff737373)),),
        ),
        SizedBox(height: 7),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 100,
                width: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xff969696)),
                ),
                child: Icon(CupertinoIcons.plus, size: 54,),
              ),
              Container(
                height: 100,
                width: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xff969696)),
                ),
                child: Icon(CupertinoIcons.plus, size: 54,),
              ),
            ],
          ),
        )
      ],
    );
  }
}
