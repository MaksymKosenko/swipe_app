import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_app/global/custom_widgets/app_bars/default_app_bar.dart';
import 'package:swipe_app/global/style/text_styles.dart';
import 'package:swipe_app/global/user.dart';
import 'package:swipe_app/screens/chat_screens/chat_screen.dart';
import 'package:swipe_app/screens/chat_screens/input.dart';
import 'package:swipe_app/screens/feed/landing_page.dart';

class UserToSupportChat extends StatefulWidget {
  @override
  _UserToSupportChatState createState() => _UserToSupportChatState();
}

class _UserToSupportChatState extends State<UserToSupportChat> {
  CollectionReference _chats = FirebaseFirestore.instance.collection('chats');
  TextEditingController _chatController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  Future<bool> checkChat(String userId, String otherUser) async {
    DocumentReference _concreteChat = FirebaseFirestore.instance
        .collection('chats')
        .doc('$userId')
        .collection('chats')
        .doc('$otherUser');
    try {
      var doc = await _concreteChat.get();
      //print(doc.exists);
      return doc.exists;
    } catch (e) {
      print(e);
    }
  }

  Future<void> createChat(String userId, String otherUser, String text) {
    return _chats
        .doc('$userId')
        .collection('chats')
        .doc('$otherUser')
        .set({'owner': userId, 'client': "$otherUser"}).then((value) {
      setName(userId, otherUser);
      setName(otherUser, userId);
      createMessage(userId, otherUser, text, 0);
      createMessage(otherUser, userId, text, 0);
      isChatExist = true;
    }).catchError((error) => print("Failed to add chat: $error"));
  }

  Future<void> setName(String id, String otherUserId) async {
    try {
      DocumentSnapshot user = await FirebaseFirestore.instance
          .collection('users')
          .doc('$otherUserId')
          .get();
      if (user != null) {
        return _chats
            .doc("$id")
            .collection("chats")
            .doc("$otherUserId")
            .update({
              'name': "${user.data()['name']} ${user.data()['surName']}",
              'photo': "${user.data()['profilePic']}"
            })
            .then((value) => print("username added"))
            .catchError((error) => print("Failed to add username: $error"));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> createMessage(
      String userId, String otherUser, String text, int index) {
    return _chats
        .doc('$userId')
        .collection('chats')
        .doc('$otherUser')
        .collection('messages')
        .doc('message$index')
        .set({
      'message$index': text,
      'author': userId,
      'time': Timestamp.now(),
    }).then((value) {
      _chatController.clear();
      createLastMessage(text, userId, otherUser);
      createLastMessage(text, otherUser, userId);
      print("$index message added");
    }).catchError((error) => print("Failed to add 1s message: $error"));
  }

  Future<void> createLastMessage(String text, String id, String otherUserId) {
    return _chats
        .doc("$id")
        .collection("chats")
        .doc("$otherUserId")
        .update({'lastMessage': "$text", 'lastTime': Timestamp.now()})
        .then((value) => print("lastMessage added"))
        .catchError((error) => print("Failed to add lastMessage: $error"));
  }

  Future<void> pushMessageToDB(
      String userId, String otherUser, String text) async {
    try {
      await FirebaseFirestore.instance
          .collection('chats')
          .doc('$userId')
          .collection('chats')
          .doc('$otherUser')
          .collection('messages')
          .get()
          .then((value) {
        createMessage(userId, otherUser, text, value.size);
        createMessage(otherUser, userId, text, value.size);
      });
      _chatController.clear();
      //print("messages length - ${docs}");
    } catch (e) {
      print(e);
    }
  }

  Future<void> getLength(String userId) async {
    try {
      await FirebaseFirestore.instance
          .collection('chats')
          .doc('$userId')
          .collection('chats')
          .doc('Support')
          .collection('messages')
          .get()
          .then((value) => {
      _chatController.clear(),
                if (value.size != counter)
                  setState(() {
                    counter = value.size;
                  }),
              });
      Timer(Duration(milliseconds: 1), () => _scrollController
          .jumpTo(_scrollController.position.maxScrollExtent));
      //print("messages length - ${docs}");
    } catch (e) {
      print(e);
    }
  }

  int counter = 0;
  bool isChatExist; // = false;
  @override
  Widget build(BuildContext context) {
    final ConcreteUser user = Provider.of<ConcreteUser>(context);
    getLength(user.phone);
    //createChat();
    if (isChatExist == null)
      checkChat(user.phone, "Support").then((value) => value == true
          ? {
              print("exist"),
              setState(() {
                isChatExist = true;
              })
            }
          : {
              print("Notexist"),
              setState(() {
                isChatExist = false;
              })
            });

    //List<dynamic> _messages = [];

    void sendMessage(String text) {
      if (text.isNotEmpty) {
        print("text exist in sendMessage");
        pushMessageToDB(user.phone, "Support", text);
        pushMessageToDB("Support", user.phone, text);
      } else
        print("text not exist");
    }

    void startChat(String text) {
      if (text.isNotEmpty) {
        print("text exist");
        createChat(user.phone, "Support", text);
        createChat("Support", user.phone, text);
      } else
        print("text not exist");
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyCustomAppBar(
        "Обратная связь",
        82,
        MaterialPageRoute(builder: (context) => ChatScreen()),
      ),
      //MaterialPageRoute(builder: (context) => LandingPage()),),
      body: Container(
          padding: EdgeInsets.only(top: 20),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: getMessages(user.phone)),
              Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                color: Color(0xffF1F1F1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      CupertinoIcons.paperclip,
                      color: Color(0xff8C8C8C),
                    ),
                    InputChat(_chatController, _scrollController, "Ок, супер!"),
                    GestureDetector(
                      onTap: () {
                        print("ischatexist - $isChatExist");
                        isChatExist
                            ? sendMessage(_chatController.text)
                            : startChat(_chatController.text);
                        Timer(Duration(milliseconds: 100), () => _scrollController
                            .jumpTo(_scrollController.position.maxScrollExtent));
                      },
                      child: Container(
                          height: 50,
                          width: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              gradient: LinearGradient(
                                //stops: [2],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xff56C587),
                                  Color(0xff43C1B5),
                                ],
                              )),
                          child: Icon(
                            CupertinoIcons.paperplane,
                            color: Colors.white,
                            size: 28,
                          )),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget getMessages(String userId) {
    Stream _messages = FirebaseFirestore.instance
        .collection('chats')
        .doc('$userId')
        .collection('chats')
        .doc('Support')
        .collection("messages")
        .orderBy("time", descending: false)
        .snapshots();
    return StreamBuilder(
        stream: _messages,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          var data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            Timer(Duration(milliseconds: 100), () => _scrollController
                .jumpTo(_scrollController.position.maxScrollExtent));
            return Container();
          }
          if (snapshot.connectionState == ConnectionState.active) {
            snapshot.data.toString();
            data = snapshot.data;
            print("data docs length - ${data.docs.length}");
            Timer(Duration(milliseconds: 100), () => _scrollController
                .jumpTo(_scrollController.position.maxScrollExtent));
            return ListView.builder(
              //reverse: true,
              itemCount: data.docs.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                print("index - $index");
                if (data.docs[index]['author'] == userId)
                  return sendedMessage("${data.docs[index]['message$index']}");
                else
                  return recivedMessage("${data.docs[index]['message$index']}");
              },
            );
          }
          return Container(
            color: Colors.white,
          );
        });
  }

  Widget sendedMessage(String text) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        padding: EdgeInsets.only(right: 10, left: 50, top: 5, bottom: 5),
        child: Container(
          //alignment: Alignment.topRight,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xff41BFB5)),
          child: Text(
            "$text",
            style: MediumText(12, Colors.white),
          ),
        ),
      ),
    );
  }

  Widget recivedMessage(String text) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        padding: EdgeInsets.only(right: 50, left: 10, top: 5, bottom: 5),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xffECECEC)),
          child: Text(
            "$text",
            style: MediumText(12, Color(0xff696969)),
          ),
        ),
      ),
    );
  }
}
