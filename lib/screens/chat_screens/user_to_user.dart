import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_app/global/custom_widgets/app_bars/default_app_bar.dart';
import 'package:swipe_app/models/repository/api_add.dart';
import 'package:swipe_app/screens/add_cards/full_ad_card.dart';
import 'package:swipe_app/screens/chat_screens/input.dart';

class UserToUserChat extends StatefulWidget {
  final String _userName;
  final String _userSurName;
  final ApiAdd _add;
  final String _id;
  UserToUserChat(this._userName, this._userSurName, this._add, this._id);
  @override
  _UserToUserChatState createState() => _UserToUserChatState();
}

class _UserToUserChatState extends State<UserToUserChat> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _chatController = TextEditingController();
    return Scaffold(
      appBar: MyCustomAppBar("${widget._userName} ${widget._userSurName}", 82,
        MaterialPageRoute(builder: (context) => FullAdCard(widget._add, widget._id)),),
      body: Container(
        color: Colors.white,
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        color: Color(0xffF1F1F1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(CupertinoIcons.paperclip, color: Color(0xff8C8C8C),),
            InputChat(_chatController, "Ок, супер!"),
            Container(
              height: 50, width: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                  //stops: [2],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff56C587),
                    Color(0xff43C1B5),
                  ],
                )),
                child: Icon(CupertinoIcons.paperplane ,color: Colors.white,size: 28,))
          ],
        ),
      ),
    );
  }
}
