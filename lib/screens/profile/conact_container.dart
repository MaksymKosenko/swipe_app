import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:swipe_app/global/custom_widgets/custom_button.dart';
import 'package:swipe_app/global/style/text_styles.dart';
import 'package:swipe_app/global/user.dart';
import 'package:swipe_app/screens/profile/Profile_input.dart';

class CustomMyContacts extends StatefulWidget {
  final dynamic _parentWidget;
  CustomMyContacts(this._parentWidget);

  @override
  _CustomMyContactsState createState() => _CustomMyContactsState();
}

class _CustomMyContactsState extends State<CustomMyContacts> {
  bool isExpandedMyCont = false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _surController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override


  Widget build(BuildContext context) {
    final ConcreteUser user = Provider.of<ConcreteUser>(context);
    //final String _documentId = user.phone;
    CollectionReference _users = FirebaseFirestore.instance.collection('users');
    //DocumentReference _user = _users.doc(_documentId);


    //DocumentReference _agent = _users.doc(_documentId).collection("user_collections").doc("Agent");
    // var test = _agent.get();
    return FutureBuilder<DocumentSnapshot>(
        future: _users.doc(user.phone).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data.data();
            print(data);
            return MyContacts(user.phone, data,_users);
          }
          return Container(
            height: 64,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent,
                border: Border.all(color: Color(0xffE1E1E1))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: EdgeInsets.only(left: 24),
                    child: Text(
                      "Мои контакты",
                      style: RegularText(16, Color(0xff2E2E2E)),
                    )),
                IconButton(
                  icon: Icon(Icons.keyboard_arrow_down),
                  onPressed: null,
                ),
              ],
            ),
          );
        });
  }

  Widget MyContacts(phone,_user, _users) {
    Future<void> setUserName(String name) {
     // print("testing $_user, $name");
      return _users
          .doc(phone)
          .update({
            'name': '$name'
          })
          .then((value) => print("Contacts updated, $name"))
          .catchError((error) => print("Failed update Contacts: $error"));
    }

    Future<void> setUserSurName(String surName) {
      return _users
          .doc(phone)
          .update({
            'surName': surName,
          })
          .then((value) => print("Contacts updated, $surName"))
          .catchError((error) => print("Failed update Contacts: $error"));
    }
    Future<void> setUserEmail(String email) {
      return _users
          .doc(phone)
          .update({
            'email': email,
          })
          .then((value) => print("Contacts updated, $email"))
          .catchError((error) => print("Failed update Contacts: $error"));
    }
    changeView() {
      setState(() {
        isExpandedMyCont = !isExpandedMyCont;
        //print(isExpandedMyCont);
      });
    }
    saveChanges(){
      if(_nameController.text != ""){
        setUserName(_nameController.text);
        widget._parentWidget.setState(() {
          print("should to work");
        });
      }
      if(_surController.text != "")
        setUserSurName(_surController.text);
      widget._parentWidget.setState(() {
        print("should to work");
      });
      if(_emailController.text != "")
        setUserEmail(_emailController.text);
      widget._parentWidget.setState(() {
        print("should to work");
      });
    }

    if (isExpandedMyCont) {
      return Container(
            //height: 444,
            height: 476,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent,
                border: Border.all(color: Color(0xffE1E1E1))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                onTap:()=> changeView(),
                  child: Container(
                    height: 62,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 24),
                            child: Text(
                              "Мои контакты", style: RegularText(16, Color(0xff2E2E2E)),
                            ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Icon(Icons.keyboard_arrow_up),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 24),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  //width: 307,
                  height: 71,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Имя", style: SemiBoldText(14, Color(0xff2E2E2E))),
                      SizedBox(height: 10),
                      ProfileInput(_user['name'], _nameController, false)
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  //width: 307,
                  height: 71,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Фамилия",
                          style: SemiBoldText(14, Color(0xff2E2E2E))),
                      SizedBox(height: 10),
                      ProfileInput(_user['surName'], _surController, false)
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  //width: 307,
                  height: 71,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Телефон",
                          style: SemiBoldText(14, Color(0xff2E2E2E))),
                      SizedBox(height: 10),
                      Container(
                        height: 44,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Color(0x64DADADA),//32
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text("${_user['phone']}", style: RegularText(14,Color(0xff737373)),),)
                      //ProfileInput(_user['phone'], _phoneController, false)
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  //width: 307,
                  height: 71,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email", style: SemiBoldText(14, Color(0xff2E2E2E))),
                      SizedBox(height: 10),
                      ProfileInput(_user['email'], _emailController, false)
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  child: GestureDetector(
                    child: CustomButton(128, 32, 12, Colors.transparent, Colors.transparent,
                      Alignment.topCenter, Alignment.bottomCenter, "Сохранить", RegularText(16, Color(0xff2E2E2E)), Color(0xffE2E2E2)),
                  onTap: (){saveChanges(); changeView();} ,
                  ),)
              ],
            ),
          );
    } else {
      return GestureDetector(
            child: Container(
              height: 64,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.transparent,
                  border: Border.all(color: Color(0xffE1E1E1))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 24),
                      child: Text(
                        "Мои контакты",
                        style: RegularText(16, Color(0xff2E2E2E)),
                      )),
                  IconButton(
                    icon: Icon(Icons.keyboard_arrow_down),
                    onPressed: null,
                  ),
                ],
              ),
            ),
            onTap: () => changeView(),
          );
    }
  }
}
