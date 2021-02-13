import 'package:flutter/material.dart';
import 'package:swipe_app/basicThings/basic.dart';
import 'package:swipe_app/screens/verificationScreen.dart';
import 'package:swipe_app/services/auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _phoneController = TextEditingController();
  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: GradientBack(),
        child: Column(
          children: [
            SizedBox(height: 166),
            Logo(41.62, 62, 42, 15),
            //Image.asset('lib/assets/images/Group1.png', width: 220, height: 53),
            SizedBox(height: 72),
            input(253, 44, _phoneController, false, TextInputType.phone,
            RegularText(16, Colors.white), RegularText(16, Colors.white), "Телефон", Color(0xff56C385)),
            //_input("Телефон", _phoneController, false),
            SizedBox(height: 25),
            GestureDetector(
              onTap: (){
                var phoneToCheck = _phoneController.text;
                if(phoneToCheck.startsWith("+") && phoneToCheck.length >= 12 && phoneToCheck.length <= 16) {
                  print("fine user phone");
                  _authService.checkPhone(_phoneController.text);
                  Navigator.push(context, MaterialPageRoute(
                       builder: (context) => VerificationScreen(_phoneController.text, null, _authService)));
                }else{
                  showError();
                }
                //Navigator.push(context, MaterialPageRoute(
                   // builder: (context) => VerificationScreen(_phoneController.text, _authService)));
                },
              child:CustomButton(253, 50, 10, Color(0xff56C385), Color(0xff41BFB5),Alignment.topCenter,
                  Alignment.bottomCenter, "Далее", SemiBoldText(16), Colors.transparent),
            ),
          ],
        ),
      ),
    );
  }

  Future <void> showError() async{
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Your phone number is incorrect'),
                Text('Try to start with + and country code'),
                Text('or check input correction'),
              ],
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
    );
  }
}
