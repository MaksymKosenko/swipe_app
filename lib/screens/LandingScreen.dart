import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_app/User.dart';
class LandingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final ConcreteUser user = Provider.of<ConcreteUser>(context);
    return Scaffold(
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
}
