import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_app/global/custom_widgets/app_bars/feed_app_bar.dart';
import 'package:swipe_app/global/custom_widgets/custom_drawer.dart';
import 'package:swipe_app/global/user.dart';
import 'package:swipe_app/screens/Feed/ads_list.dart';
import 'package:swipe_app/screens/Feed/filters.dart';

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
    return StreamBuilder<DocumentSnapshot>(
        stream: _users.doc(_documentId).get().asStream(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =  snapshot.data.data();

                _userFromFirestoreData = data;
                print("landing page data = $data");
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
