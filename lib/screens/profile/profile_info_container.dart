import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_app/global/style/text_styles.dart';
import 'package:swipe_app/global/user.dart';

class ProfileInfo extends StatefulWidget {
  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  @override
  Widget build(BuildContext context) {
    final ConcreteUser user = Provider.of<ConcreteUser>(context);
    CollectionReference _users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
        future: _users.doc(user.phone).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data.data();
            return   Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: 24,
                      child: Text(
                        "${data['name']} ${data['surName']}",
                        style: RegularText(20, Color(0xff2E2E2E)),
                      )),
                  SizedBox(height: 5),
                  Container(
                      height: 17,
                      child: Text(
                        "${data['email']}",
                        style: RegularText(14, Color(0xff2E2E2E)),
                      )),
                ],
              ),
            );
          }
          return Container();
        });
  }
}
