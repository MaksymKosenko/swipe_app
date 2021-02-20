import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_app/User.dart';
import 'package:swipe_app/basicThings/basic.dart';
import 'package:swipe_app/screens/profile/ProfileInput.dart';

class CustomMyContacts extends StatefulWidget {
  @override
  _CustomMyContactsState createState() => _CustomMyContactsState();
}

class _CustomMyContactsState extends State<CustomMyContacts> {
  bool isExpandedMyCont = false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _surController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ConcreteUser user = Provider.of<ConcreteUser>(context);
    final String _documentId = user.phone;
    CollectionReference _users = FirebaseFirestore.instance.collection('users');
    //DocumentReference _agent = _users.doc(_documentId).collection("user_collections").doc("Agent");
    // var test = _agent.get();
    return FutureBuilder<DocumentSnapshot>(
        future: _users.doc(_documentId).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data.data();
            //_userFromFirestoreData = data;
            return MyContacts(data);
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

  Widget MyContacts(_userData) {
    changeView() {
      setState(() {
        isExpandedMyCont = !isExpandedMyCont;
        print(isExpandedMyCont);
      });
    }

    return isExpandedMyCont
        ? Container(
            height: 444,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent,
                border: Border.all(color: Color(0xffE1E1E1))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 62,
                  child: GestureDetector(
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
                      onTap: () => changeView()
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
                      ProfileInput(_userData['name'], _nameController, false)
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
                      ProfileInput(_userData['surName'], _surController, false)
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
                      ProfileInput(_userData['phone'], _phoneController, false)
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
                      ProfileInput(_userData['email'], _emailController, false)
                    ],
                  ),
                ),
              ],
            ),
          )
        : GestureDetector(
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
