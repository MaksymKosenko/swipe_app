import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_app/basicThings/User.dart';
import 'package:swipe_app/basicThings/CustomAppBars.dart';
import 'package:swipe_app/basicThings/basic.dart';
import 'package:swipe_app/screens/Feed/LandingScreen.dart';
import 'package:swipe_app/screens/profile/agentContainer.dart';
import 'package:swipe_app/screens/profile/conactContainer.dart';
import 'package:swipe_app/screens/profile/notificationContainer.dart';
import 'package:swipe_app/screens/profile/subscribtionContainer.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  final dynamic _userData;

  ProfileScreen(this._userData);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  CollectionReference _users = FirebaseFirestore.instance.collection('users');
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  File _image;
  final picker = ImagePicker();

  Future getImage(source) async {
    final pickedFile = await picker.getImage(source: source);//ImageSource.gallery);//ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        storage
            .ref()
            .child(widget._userData['phone'])
            .child("profilePic")
            .putFile(_image);

        downloadURL();
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> addUserPhoto(String link) {
    String _phone = widget._userData['phone'];
    return _users
        .doc(_phone)
        .update({
      'profilePic': "$link",
    })
        .then((value) => print("user profilePic added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
  Future<void> downloadURL() async {
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref("${widget._userData['phone']}/profilePic")
        .getDownloadURL();
    addUserPhoto(downloadURL);
  }

  Future <void> choosePicker() async{
    return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("choose input type", style: SemiBoldText(16, Colors.black)),
        content: Text("Выберите способ ввода данных", style: RegularText(14, Colors.black)),
        actions: [
          TextButton(
            onPressed: (){Navigator.of(context).pop(); getImage(ImageSource.camera);},
            child: Text("Камера",style: SemiBoldText(16, Colors.black))),
          TextButton(
            onPressed: (){Navigator.of(context).pop();getImage(ImageSource.gallery);},
            child: Text("Галерея", style:SemiBoldText(16, Colors.black)))
    ],
    );
    });}

  Widget build(BuildContext context) {
    bool _isImageExist;
    if(widget._userData['profilePic'] == "null")
    _isImageExist = false;
    else
      _isImageExist = true;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyCustomAppBar(
        title: "Личный кабинет",
        height: 104,//64
        backScreen: MaterialPageRoute(builder: (context) => LandingPage()),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          Row(children: [
            GestureDetector(
              child: Container(
                  height: 80,
                  width: 80,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: _isImageExist ? DecorationImage(image: NetworkImage(widget._userData['profilePic']), fit: BoxFit.fill) : null,
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: Color(0xff969696))),
                  child: _isImageExist ? null : Icon(CupertinoIcons.plus,size: 32,)),
              onTap: (){choosePicker();},
            ),//Text("no")),
            //TODO сделать вместо надписей картинку/+
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: 24,
                    child: Text(
                      "${widget._userData['name']} ${widget._userData['surName']}",
                      style: RegularText(20, Color(0xff2E2E2E)),
                    )),
                SizedBox(height: 5),
                Container(
                    height: 17,
                    child: Text(
                      "${widget._userData['email']}",
                      style: RegularText(14, Color(0xff2E2E2E)),
                    )),
              ],
            ),
          ]),
          SizedBox(height: 40),
          CustomMyContacts(),
          SizedBox(height: 20),
          CustomAgentContacts(),
          SizedBox(height: 20),
          CustomSubscription(),
          SizedBox(height: 20),
          CustomNotification(),
          SizedBox(height: 35),
          Container(
            height: 34,
            child: Row(
              children: [
                SizedBox(width: 10),
                Container(
                    height: 34,
                    width: 190,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Переключить звонки",
                            style: RegularText(14, Color(0xff2E2E2E))),
                        Text("и сообщения на агента",
                            style: RegularText(14, Color(0xff2E2E2E))),
                      ],
                    )),
                SizedBox(width: 120),
                CustomSlider(),
              ],
            ),
          ),
          SizedBox(height: 30),
          Text(
            "Политика конфиденциальности",
            style: RegularText(14, Color(0xff1CA198)),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

}

class CustomSlider extends StatefulWidget {
  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  bool _currentValue = false;
  @override
  Widget build(BuildContext context) {
    final ConcreteUser user = Provider.of<ConcreteUser>(context);
    final String _documentId = user.phone;
    CollectionReference _users = FirebaseFirestore.instance.collection('users');
    DocumentReference _agent = _users
        .doc(_documentId)
        .collection("user_collections")
        .doc("Notifications");
    Future<void> setNotificationsData(newValue) {
      return _agent
          .update({
        'disable': false,
        'toAgent': newValue,
        'toEach': false,
        'toUser': !newValue,
      })
          .then((value) => print("Notifications added"))
          .catchError((error) => print("Failed to add Notifications: $error"));
    }
    return FutureBuilder<DocumentSnapshot>(
        future: _agent.get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data.data();
            _currentValue = data['toAgent'];
            //_userFromFirestoreData = data;
            return Container(
                width: 45,
                height: 25,
                child: CupertinoSwitch(value: _currentValue,
                    activeColor: Color(0xff27AE60),
                    onChanged: (newValue){
                      setState(() {
                        _currentValue = newValue;
                        setNotificationsData(_currentValue);
                        print("current value, newVaulue $_currentValue, $newValue");});})
            );
          }
          return Container(
              width: 45,
              height: 25,
              child: CupertinoSwitch(value: _currentValue,
                  activeColor: Color(0xff27AE60),
                  onChanged: null)
          );
        });
  }
}
