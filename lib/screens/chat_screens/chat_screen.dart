import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_app/global/custom_widgets/app_bars/default_app_bar.dart';
import 'package:swipe_app/global/style/text_styles.dart';
import 'package:swipe_app/global/user.dart';
import 'package:swipe_app/screens/chat_screens/default_chat_screen.dart';
import 'package:swipe_app/screens/chat_screens/user_to_support.dart';
import 'package:swipe_app/screens/chat_screens/user_to_user.dart';
import 'package:swipe_app/screens/feed/landing_page.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Future<void> getMessages() async {
    try {} catch (e) {
      print("error - $e");
    }
  }

  Future<void> getUserInfo(int index, String phone, String name) async {
    try {
      DocumentSnapshot user = await FirebaseFirestore.instance.collection('users')
          .doc('$phone').get();
      name = "${user.data()['name']} + ${user.data()['surName']}";
      print("name = $name");
    } catch (e) {
      print("error - $e");
    }
  }
  /* Future<void> getLength(String userId) async{
    try{
      await  FirebaseFirestore.instance.collection('chats')
          .doc('${userId}toSupport').collection('messages')
          .get()
          .then((value)=> { if(value.size != counter) setState(() {counter = value.size;
          print("value docs 0 - ${value.docs[0].data()['${0} message']}");
        //  lastMessage = value.docs[counter - 1].data()['${counter - 1} message'];
         // print("test - ${value.docs[counter - 1].data()['${counter - 1} message']}");
          })});
      print("counter-1 - ${counter-1}, ${counter-1} message");
    }catch(e){
      print(e);
    }
  }
  String lastMessage = "последнее сообщение";
  */
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    final ConcreteUser user = Provider.of<ConcreteUser>(context);
    getMessages();
    //getLength(user.phone);
    Stream _messages = FirebaseFirestore.instance
        .collection('chats')
        .doc('${user.phone}')
        .collection('chats')
        .orderBy("lastTime", descending: true)
        .snapshots(); //.orderBy("time", descending: false)
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyCustomAppBar(
          "Чаты", 82, MaterialPageRoute(builder: (context) => LandingPage())),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: StreamBuilder(
              stream: _messages,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                if (snapshot.connectionState == ConnectionState.active) {
                  int counter = snapshot.data.docs.length;
                  print("couner - $counter");
                  List<String> _names = [];
                 /* for(int i = 0; i < counter; i++){
                    String _name ="";

                    if(_name != "")
                      _names.add(_name);
                  }*/

                  return ListView.separated(
                      itemCount: counter,
                      //padding: EdgeInsets.symmetric(vertical: 5),
                      separatorBuilder: (BuildContext context, int index) => Divider(),
                      itemBuilder:(BuildContext context, int index) {
                        String _otherUserPhone;
                        if(snapshot.data.docs[index]['client'] == user.phone)
                          _otherUserPhone = snapshot.data.docs[index]['owner'];
                        else _otherUserPhone = snapshot.data.docs[index]['client'];
                        return  GestureDetector(
                          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>
                              DefaultChat(snapshot.data.docs[index]['name'], user.phone, _otherUserPhone))),
                          child: Container(
                            height: 70,
                            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Color(0x32DADADA)),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:[
                                  Row(children: [
                                    Container(height: 60, width: 60,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                                          color: Color.lerp(Color(0xff56C587), Color(0xff43C1B5), 0.5),
                                      image: DecorationImage(image: NetworkImage(snapshot.data.docs[index]['photo']))),),
                                    SizedBox(width: 20),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(snapshot.data.docs[index]['name'], style: RegularText(18, Colors.black),),
                                        Text(snapshot.data.docs[index]['lastMessage'],style: RegularText(15, Color(0xff2E2E2E)),),
                                      ],),
                                  ],),

                                  IconButton(icon: Icon(CupertinoIcons.trash_circle,size: 30, color: Color(0xffEB5757)), onPressed: null)
                                ]
                            ),
                          ),
                        );
                      }
                  );
                }

                return ListView.builder(
                    itemCount: counter,
                    padding: EdgeInsets.symmetric(vertical: 5),
                    itemBuilder:(BuildContext context, int index) {
                     // String _name;
                     // getUserInfo(index, user.phone, _name);
                      return  GestureDetector(
                        //onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> UserToSupportChat())),
                        child: Container(
                          height: 70,
                          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Color(0xffECECEC)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:[
                                Row(children: [
                                  Container(height: 60, width: 60,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                                        color: Color.lerp(Color(0xff56C587), Color(0xff43C1B5), 0.5)), ),
                                  SizedBox(width: 20),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Тех поддержка", style: RegularText(18, Colors.black),),
                                      Text("lastMessage",style: RegularText(15, Color(0xff2E2E2E)),),
                                    ],),
                                ],),

                                IconButton(icon: Icon(CupertinoIcons.trash_circle,size: 30, color: Color(0xffEB5757)), onPressed: null)
                              ]
                          ),
                        ),
                      );
                    }
                );
              })),
      floatingActionButton: FloatingActionButton(
          backgroundColor:
              Color.lerp(Color(0xff56C587), Color(0xff43C1B5), 0.5),
          child: Icon(
            Icons.support_agent_rounded,
            size: 32,
          ),
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => UserToSupportChat()))),
    );
  }
}

/*
 GestureDetector(
              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> UserToSupportChat())),
              child:
            )

Container(
                height: 70,
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Color(0xffECECEC)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Row(children: [
                      Container(height: 60, width: 60,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                            color: Color.lerp(Color(0xff56C587), Color(0xff43C1B5), 0.5)), ),
                      SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Тех поддержка", style: RegularText(18, Colors.black),),
                          Text("$lastMessage",style: RegularText(15, Color(0xff2E2E2E)),),
                        ],),
                    ],),

                    IconButton(icon: Icon(CupertinoIcons.trash_circle,size: 30, color: Color(0xffEB5757)), onPressed: null)
                  ]
                ),
              ),
              */
