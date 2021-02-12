
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_app/User.dart';
class MapPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final ConcreteUser user = Provider.of<ConcreteUser>(context);
    return Scaffold(
      body: Center(child: Row(
        children: [
          // Text("${user.name} "),
          // Text(" ${user.id} "),
          // Text(" ${user.email}"),
        ],
      )),
    );
  }
}
