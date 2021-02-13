import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_app/User.dart';
import 'package:swipe_app/basicThings/CustomDrawer.dart';

class LandingPage extends StatelessWidget {
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
                  //drawerScrimColor: Color(0xff27AEA4),
                    drawer: CustomDrawer(context, _userFromFirestoreData),
                    appBar: AppBar(
                      backgroundColor: Colors.white,
                      iconTheme: IconThemeData(color: Color(0xff27AEA4)),
                    ),
                    body: Container(
                      width: 100,
                      height: 300,
                      child: Column(
                        children: [
                          SizedBox(height: 50),
                          Text(user.id),
                          Text(user.phone),
                        ],
                      ),
                    )
                );
              }
              return Scaffold(drawer: CircularProgressIndicator(),);
            }

    );
  }
}
