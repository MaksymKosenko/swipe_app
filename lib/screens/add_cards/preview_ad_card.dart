import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_app/global/style/text_styles.dart';
import 'package:swipe_app/models/repository/api_add.dart';

class PreviewAdCard extends StatefulWidget {
  final ApiAdd _add;

  PreviewAdCard(this._add);

  @override
  _PreviewAdCardState createState() => _PreviewAdCardState();
}

class _PreviewAdCardState extends State<PreviewAdCard> {
  void changeView(String way, int currentIndex){
    switch(way){
      case "left": print("left");if(currentIndex > 0) setState(() {
        currentIndex--;
        photoIndex = currentIndex;
        print(currentIndex);
      });break;
      case "right": print("right"); if(currentIndex < widget._add.photos.length-1) setState(() {
        currentIndex++;
        photoIndex = currentIndex;
      });break;
    }
  }

  int photoIndex = 0;
  @override
  Widget build(BuildContext context) {
    bool isFewImages = false;
    String selectedImage = widget._add.photos[photoIndex];
    if (widget._add.photos.length > 1) isFewImages = true;
    print("phtos length - ${widget._add.photos.length}");
    print("photo index - $photoIndex");
    return Container(
      height: 283, //205 //275
      //width: 355,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        children: [
          isFewImages
              ? Stack(children: [
            Container(
              height: 205, //width: 355,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(selectedImage),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  dotsBuilder(widget._add.photos.length, photoIndex),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 82),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: ()=> changeView("left", photoIndex),
                    child: Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(20)),
                      child: Icon(
                        CupertinoIcons.chevron_left,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: ()=> changeView("right", photoIndex),
                    child: Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(20)),
                      child: Icon(
                        CupertinoIcons.chevron_right,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ])
              : Container(
            height: 205, //width: 355,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(selectedImage), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget._add.roomsQuantity}, ${widget._add
                          .overallArea}М\u{00B2}",
                      style: MediumText(12, Colors.black),
                    ),
                    SizedBox(height: 9),
                    Container(
                        width: 140, //160
                        child: Text(
                          widget._add.address,
                          style: MediumText(12, Color(0xff414141)),
                          overflow: TextOverflow.clip,
                        )),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${widget._add.cost} ₴",
                      style: SemiBoldText(18, Colors.black),
                    ),
                    SizedBox(height: 4),
                    Text("Смотреть объявление",
                        style: SemiBoldText(12, Color(0xff27AEA4)))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget dotsBuilder(int length, int index) {
    switch (length) {
      case 2:
        return Row(
          children: [
            index == 0 ? Container(height: 8, width: 8, decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.white))
                : Container(height: 6, width: 6, decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Colors.white60)),
            SizedBox(width: 10),
            index == 1 ? Container(height: 8, width: 8, decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.white))
                : Container(height: 6, width: 6, decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Colors.white60)),
          ],
        ); break;
      case 3:
        return Row(
          children: [
            index == 0 ? Container(height: 8, width: 8, decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.white))
                : Container(height: 6, width: 6, decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Colors.white60)),
            SizedBox(width: 10),
            index == 1 ? Container(height: 8, width: 8, decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.white))
                : Container(height: 6, width: 6, decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Colors.white60)),
            SizedBox(width: 10),
            index == 2 ? Container(height: 8, width: 8, decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.white))
                : Container(height: 6, width: 6, decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Colors.white60)),
          ],
        ); break;
      case 4:
        return Row(
          children: [
            index == 0 ? Container(height: 8, width: 8, decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.white))
                : Container(height: 6, width: 6, decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Colors.white60)),
            SizedBox(width: 10),
            index == 1 ? Container(height: 8, width: 8, decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.white))
                : Container(height: 6, width: 6, decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Colors.white60)),
            SizedBox(width: 10),
            index == 2 ? Container(height: 8, width: 8, decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.white))
                : Container(height: 6, width: 6, decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Colors.white60)),
            SizedBox(width: 10),
            index == 3 ? Container(height: 8, width: 8, decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.white))
                : Container(height: 6, width: 6, decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Colors.white60)),
          ],
        ); break;
      case 5:
        return Row(
          children: [
            index == 0 ? Container(height: 8, width: 8, decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.white))
                : Container(height: 6, width: 6, decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Colors.white60)),
            SizedBox(width: 10),
            index == 1 ? Container(height: 8, width: 8, decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.white))
                : Container(height: 6, width: 6, decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Colors.white60)),
            SizedBox(width: 10),
            index == 2 ? Container(height: 8, width: 8, decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.white))
                : Container(height: 6, width: 6, decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Colors.white60)),
            SizedBox(width: 10),
            index == 3 ? Container(height: 8, width: 8, decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.white))
                : Container(height: 6, width: 6, decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Colors.white60)),
            SizedBox(width: 10),
            index == 4 ? Container(height: 8, width: 8, decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.white))
                : Container(height: 6, width: 6, decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Colors.white60)),
          ],
        ); break;
      case 6:
        return Row(
          children: [
            index == 0 ? Container(height: 8, width: 8, decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.white))
                : Container(height: 6, width: 6, decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Colors.white60)),
            SizedBox(width: 10),
            index == 1 ? Container(height: 8, width: 8, decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.white))
                : Container(height: 6, width: 6, decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Colors.white60)),
            SizedBox(width: 10),
            index == 2 ? Container(height: 8, width: 8, decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.white))
                : Container(height: 6, width: 6, decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Colors.white60)),
            SizedBox(width: 10),
            index == 3 ? Container(height: 8, width: 8, decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.white))
                : Container(height: 6, width: 6, decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Colors.white60)),
            SizedBox(width: 10),
            index == 4 ? Container(height: 8, width: 8, decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.white))
                : Container(height: 6, width: 6, decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Colors.white60)),
            SizedBox(width: 10),
            index == 5 ? Container(height: 8, width: 8, decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.white))
                : Container(height: 6, width: 6, decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Colors.white60)),
          ],
        ); break;
    }
    /*return Container(
      child: Row(
        children: [
        ],
      ),
    );*/
  }
}
