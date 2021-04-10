import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_app/global/custom_widgets/app_bars/default_app_bar.dart';
import 'package:swipe_app/global/style/text_styles.dart';
import 'package:swipe_app/models/repository/api_add.dart';
import 'package:swipe_app/screens/add_cards/full_ad_card.dart';
import 'package:swipe_app/screens/chat_screens/input.dart';

class UserToUserChat extends StatefulWidget {
  final String _userName;
  final String _userSurName;
  final String _userId;
  final ApiAdd _add;
  final String _id;
  UserToUserChat(this._userName, this._userSurName, this._userId, this._add, this._id);
  @override
  _UserToUserChatState createState() => _UserToUserChatState();
}

class _UserToUserChatState extends State<UserToUserChat> {
  CollectionReference _chats = FirebaseFirestore.instance.collection('chats');
  TextEditingController _chatController = TextEditingController();


  Future<bool> checkChat() async {
    DocumentReference _concreteChat = FirebaseFirestore.instance.collection('chats').doc('${widget._userId}to${widget._add.ownerID}');
      try{
        var doc = await _concreteChat.get();
        //print(doc.exists);
        return doc.exists;
      }catch(e){
        print(e);
      }
      }

  Future<void> createChat(String text){
    return _chats
        .doc("${widget._userId}to${widget._add.ownerID}")
        .set({
      'owner': widget._add.ownerID,
      'client': widget._userId,
    })
        .then((value) => createMessage(text, 0))
        .catchError((error) => print("Failed to add chat: $error"));
  }

  Future<void> createMessage(String text, int index){
    return _chats
        .doc("${widget._userId}to${widget._add.ownerID}")
        .collection('messages')
        .doc('message$index')
        .set({'message$index' : text, 'author' : widget._userId})
        .then((value) {
          print("$index message added"); _chatController.clear();
    })
        .catchError((error) => print("Failed to add 1s message: $error"));
  }

  Future<void> pushMessageToDB(String text) async{
    try{
      var docs = await  FirebaseFirestore.instance.collection('chats')
          .doc('${widget._userId}to${widget._add.ownerID}').collection('messages')
          .get()
          .then((value) => createMessage(text, value.size));
      _chatController.clear();
      //print("messages length - ${docs}");
    }catch(e){
      print(e);
    }
  }

  Future<void> getLength() async{
    try{
      await  FirebaseFirestore.instance.collection('chats')
          .doc('${widget._userId}to${widget._add.ownerID}').collection('messages')
          .get()
          .then((value)=> { if(value.size != counter) setState(() {counter = value.size; })} );
      _chatController.clear();
      //print("messages length - ${docs}");
    }catch(e){
      print(e);
    }
  }

  int counter = 0;
  bool isChatExist;// = false;
  @override
  Widget build(BuildContext context) {
    getLength();
    //createChat();
    if(isChatExist == null)
    checkChat().then((value) => value == true ? {print("exist"), setState(() {
    isChatExist = true;}) }
        : {print("Notexist"), setState(() {isChatExist = false;})});

    //List<dynamic> _messages = [];


    void sendMessage(String text){
      if(text.isNotEmpty){
        print("text exist in sendMessage");
        pushMessageToDB(text);
      }else print("text not exist");
    }

    void startChat(String text){
      if(text.isNotEmpty){
        print("text exist");
        createChat(text);
      }else print("text not exist");
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyCustomAppBar("${widget._userName} ${widget._userSurName}", 82,
        MaterialPageRoute(builder: (context) => FullAdCard(widget._add, widget._id)),),
      body: Container(
        padding: EdgeInsets.only(top: 20),
        color: Colors.white,
        child: getMessages(),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        color: Color(0xffF1F1F1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(CupertinoIcons.paperclip, color: Color(0xff8C8C8C),),
            InputChat(_chatController, "Ок, супер!"),
            GestureDetector(
              onTap: ()=> isChatExist ? sendMessage(_chatController.text) : startChat(_chatController.text),
              child: Container(
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
                  child: Icon(CupertinoIcons.paperplane ,color: Colors.white,size: 28,)),
            )
          ],
        ),
      ),
    );
  }


  Widget getMessages(){
    String author;
    String msg;
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('chats')
            .doc('${widget._userId}to${widget._add.ownerID}').collection('messages').snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          var data;
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          if (snapshot.connectionState == ConnectionState.active) {
            data = snapshot.data;
            print("datadocslength - ${data.docs.length}");
           // print("datata in index 10  - ${data.docs[10]['message10']}");
            return ListView.builder(
              itemCount: data.docs.length,
              shrinkWrap: true,
              itemBuilder: (context, index){
                print("index - $index");
                print("drawing  - ${data.docs[index]['message$index']}");//TODO аботает до 10 сообщений, доделать
                 if(data.docs[index]['author'] == widget._userId)
                  return sendedMessage("${data.docs[index]['message$index']}");
                 else return recivedMessage("${data.docs[index]['message$index']}");
              },
            );
          }
          print("length for use - ${data.docs.length}");
        return Container();
          });

  }
  Widget sendedMessage(String text){
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        padding: EdgeInsets.only(right: 10, left: 50, top: 5, bottom: 5),
        child: Container(
          //alignment: Alignment.topRight,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xff41BFB5)),
          child: Text("$text", style: MediumText(12, Colors.white),),
        ),
      ),
    );
  }
  Widget recivedMessage(String text){
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        padding: EdgeInsets.only(right: 50, left: 10,top: 5, bottom: 5),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xffECECEC)),
          child: Text("$text", style: MediumText(12, Color(0xff696969)),),
        ),
      ),
    );
  }
}