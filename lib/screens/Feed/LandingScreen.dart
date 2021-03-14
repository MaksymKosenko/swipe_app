import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_app/basicThings/User.dart';
import 'package:swipe_app/basicThings/CustomDrawer.dart';
import 'package:swipe_app/screens/Feed/AdsList.dart';
import 'package:swipe_app/screens/Feed/FeedAppBar.dart';
import 'package:swipe_app/screens/Feed/CustomFilters.dart';
import 'package:swipe_app/screens/Feed/UpgradedADCard.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  var _userFromFirestoreData;

  @override
  Widget build(BuildContext context) {
    final ConcreteUser user = Provider.of<ConcreteUser>(context);
    final String _documentId = user.phone;
    CollectionReference _users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
        future: _users.doc(_documentId).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data = snapshot.data.data();
                _userFromFirestoreData = data;
                return Scaffold(
                    drawer: CustomDrawer(context, _userFromFirestoreData),
                    appBar: CustomFeedAppBar(),
                    backgroundColor: Colors.white,
                    body: Column(
                      children: [
                        SizedBox(height: 12),
                        CustomFilters(),
                        SizedBox(height: 20),
                        AdsList(),

                       //ListView.builder(itemBuilder: itemBuilder)
                       /* Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: SAdCard(),
                           ),
                      // SAdCard(),
                       SizedBox(height: 20),
                       UpAdCard(),*/
                      ],
                    ),
                );
              }
              return Scaffold(backgroundColor: Colors.white,
                appBar: CustomFeedAppBar());
            }

    );
  }
}
