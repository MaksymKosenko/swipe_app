import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:swipe_app/global/custom_widgets/app_bars/default_app_bar.dart';
import 'package:swipe_app/global/custom_widgets/privacy_police.dart';
import 'package:swipe_app/global/style/text_styles.dart';
import 'package:swipe_app/global/user.dart';
import 'package:swipe_app/screens/Feed/landing_page.dart';
import 'package:swipe_app/screens/profile/agent_container.dart';
import 'package:swipe_app/screens/profile/conact_container.dart';
import 'package:swipe_app/screens/profile/notification_container.dart';
import 'package:swipe_app/screens/profile/profile_info_container.dart';
import 'package:swipe_app/screens/profile/subscribtion_container.dart';

class ProfileScreen extends StatefulWidget {
  final dynamic _userData;
  ProfileScreen(
    this._userData,
  );

  getUpdate(name, surName, email){
    if(name != null)
    _userData.update('name', (value)=> name);
    if(surName != null)
      _userData.update('surName', (value)=> surName);
    if(email != null)
      _userData.update('email', (value)=> email);
  }
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  final cropKey = GlobalKey<CropState>();
  File _file;
  File _sample;
  File _lastCropped;

  @override
  void dispose() {
    super.dispose();
    _file?.delete();
    _sample?.delete();
    _lastCropped?.delete();
  }

  Future<void> _buildCroppingImage() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: true, //false, // user must tap button!
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: Color(0xff2E2E2E)),
              onPressed: ()=> Navigator.pop(context),),
              title: Text("Фото профиля", style: RegularText(20, Color(0xff2E2E2E)),),
              actions: [
                _file == null? Container() : IconButton(icon: Icon(Icons.check,color: Color(0xff2E2E2E), size: 30),
                  onPressed: (){
                    _cropImage();
                    Navigator.pop(context);
                  },)
              ],
              backgroundColor: Color(0xffF5F5F5),),
            body: Column(
              children: <Widget>[
                Expanded(
                  child: Crop.file(_sample, key: cropKey),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16),
                  alignment: AlignmentDirectional.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,//spaceAround,
                    children: <Widget>[
                      TextButton(onPressed: ()=>_openImage(ImageSource.gallery), child: Text("Галерея",style: RegularText(14, Colors.black)),),
                      TextButton(onPressed: ()=>_openImage(ImageSource.camera), child: Text("Камера",style: RegularText(14, Colors.black)),),
                    ],
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          );
        });
  }


  Future<void> _buildOpenImage() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: true, //false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Выберите источник изображения",
              style: SemiBoldText(16, Colors.black),
              textAlign: TextAlign.center,
            ),
            content: Text(
                "Выберите способ ввода данных. Вы сможете сменить источник далее",
                style: RegularText(14, Colors.black)),
            actions: [
              TextButton(
                  onPressed: () {
                    _openImage(ImageSource.camera);
                    Navigator.pop(context);
                  },
                  child: Text("Камера", style: SemiBoldText(16, Colors.black))),
              TextButton(
                  onPressed: () {
                    _openImage(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                  child: Text("Галерея", style: SemiBoldText(16, Colors.black)))
            ],
          );
        });
  }

  Future<void> _openImage(_source) async {
    final file = await ImagePicker.pickImage(source: _source);
    final sample = await ImageCrop.sampleImage(
      file: file,
      preferredSize: context.size.longestSide.ceil(),
    );

    _sample?.delete();
    _file?.delete();

    setState(() {
      _sample = sample;
      _file = file;
    });
    _sample == null ? null : _buildCroppingImage();
  }

  Future<void> _cropImage() async {
    final scale = cropKey.currentState.scale;
    final area = cropKey.currentState.area;
    if (area == null) {
      // cannot crop, widget is not setup
      return;
    }

    // scale up to use maximum possible number of pixels
    // this will sample image in higher resolution to make cropped image larger
    final sample = await ImageCrop.sampleImage(
      file: _file,
      preferredSize: (2000 / scale).round(),
    );

    final file = await ImageCrop.cropImage(
      file: sample,
      area: area,
    );

    sample.delete();

    _lastCropped?.delete();
    _lastCropped = file;

    if(_lastCropped != null){
      setState(() {
        setPhoto();
      });
    }
    debugPrint('$file');
    setState(() {

    });
  }

  Future<void> setPhoto() async{
    try{

      //data.remove('profilePic');

      //data.update('profilePic', (value) => "https://firebasestorage.googleapis.com/v0/b/my-swipe.appspot.com/o/%2B11122233344%2FprofilePic?alt=media&token=02674fab-9486-4255-95ab-94f1cfeddec5");

      await firebase_storage.FirebaseStorage.instance
         /* .ref('${widget._userData['phone']}/profilePic')
          .putFile(_lastCropped);*/
      .ref('${widget._userData['phone']}/profilePic')
      .putFile(_lastCropped);

      String downloadUrl = await firebase_storage.FirebaseStorage.instance
      .ref('${widget._userData['phone']}/profilePic')
      .getDownloadURL();

      if(downloadUrl != null) {
        print(downloadUrl);
        FirebaseFirestore.instance.collection('users').doc(
            widget._userData['phone']).update({'profilePic': downloadUrl});
      }
    }catch (e) {
      print(e);
      // e.g, e.code == 'canceled'
    }}



  Widget build(BuildContext context) {
    //print(_user.profilePhoto);
    bool _isImageExist;
    if (widget._userData['profilePic'] == "null")
      _isImageExist = false;
    else
      _isImageExist = true;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyCustomAppBar(
        "Личный кабинет",
        82, //104,//64
        MaterialPageRoute(builder: (context) => LandingPage()),
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
                      image: _isImageExist
                          ? DecorationImage(
                              image: _lastCropped == null
                                  ? NetworkImage(widget._userData['profilePic'])
                                  : FileImage(_lastCropped),
                              fit: BoxFit.fill)
                          : null,
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: Color(0xff969696))),
                  child: _isImageExist
                      ? null
                      : Icon(
                          CupertinoIcons.plus,
                          size: 32,
                        )),
              onTap: () {
                print("tap, sample - $_sample");
                _buildOpenImage();
              },
            ), //Text("no")),
            SizedBox(width: 20),
            ProfileInfo(),
          ]),
          SizedBox(height: 40),
          CustomMyContacts(this),
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
          GestureDetector(
            onTap: ()=> MaterialPageRoute(builder: (context)=> PrivacyPolice()),
            child: Text(
              "Политика конфиденциальности",
              style: RegularText(14, Color(0xff1CA198)),
              textAlign: TextAlign.center,
            ),
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
                child: CupertinoSwitch(
                    value: _currentValue,
                    activeColor: Color.lerp(Color(0xff56C385), Color(0xff41BFB5), 0.5),//Color(0xff27AE60),
                    onChanged: (newValue) {
                      setState(() {
                        _currentValue = newValue;
                        setNotificationsData(_currentValue);
                        print(
                            "current value, newVaulue $_currentValue, $newValue");
                      });
                    }));
          }
          return Container(
              width: 45,
              height: 25,
              child: CupertinoSwitch(
                  value: _currentValue,
                  activeColor: Color.lerp(Color(0xff56C385), Color(0xff41BFB5), 0.5),
                  onChanged: null));
        });
  }
}
