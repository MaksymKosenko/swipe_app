import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_app/User.dart';
import 'package:swipe_app/basicThings/CustomDrawer.dart';
import 'package:swipe_app/screens/Feed/FeedAppBar.dart';
import 'file:///C:/flutter_projects/flutterlearning/flutter_Dart_courses/swipe_app/lib/screens/Feed/CustomFilters.dart';
import 'package:swipe_app/screens/Feed/StandartADCard.dart';
import 'package:swipe_app/screens/Feed/UpgradedADCard.dart';

class LandingPage extends StatelessWidget {
  var _userFromFirestoreData;

  @override
  Widget build(BuildContext context) {
    final ConcreteUser user = Provider.of<ConcreteUser>(context);
    final String _documentId = user.phone;
    CollectionReference _users = FirebaseFirestore.instance.collection('users');
   // DocumentReference _agent = _users.doc(_documentId).collection("user_collections").doc("Agent");
   // var test = _agent.get();
    return FutureBuilder<DocumentSnapshot>(
        future: _users.doc(_documentId).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data = snapshot.data.data();
                _userFromFirestoreData = data;
                return Scaffold(
                    drawer: CustomDrawer(context, _userFromFirestoreData),
                    appBar: CustomFeedAppBar(),
                    body: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          SizedBox(height: 12),
                          CustomFilters(),
                          SizedBox(height: 20),
                         /* Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: SAdCard(),
                             ),*/
                         SAdCard(),
                         SizedBox(height: 20),
                         UpAdCard(),
                        ],
                      ),
                    ),
                );
              }
              return Scaffold(backgroundColor: Colors.white,
                appBar: CustomFeedAppBar());
            }

    );
  }
}
