
import 'package:flutter/material.dart';

class PrivacyPolice extends StatefulWidget {
  Future<String> text;
  @override
  _PrivacyPoliceState createState() => _PrivacyPoliceState();
}

class _PrivacyPoliceState extends State<PrivacyPolice> {
  @override
  Widget build(BuildContext context) {
    showInfo();
    return Container(
      //child: Text(widget.text.toString()),
    );
  }

  Future <void> showInfo() async{
    //return DefaultAssetBundle.of(context).loadString("assets/privacy");
    widget.text = DefaultAssetBundle.of(context).loadString("assets/privacy");
      /*showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text('Политика конфиденциальности'),
            content: SingleChildScrollView(
              child: Container(

              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Try again'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );*/
  }
}
