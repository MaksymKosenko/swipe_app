import 'package:flutter/material.dart';
import 'package:swipe_app/basicThings/basic.dart';
import 'package:swipe_app/screens/registrationScreen.dart';
import 'package:swipe_app/screens/verificationScreen.dart';
import 'package:swipe_app/services/auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _phoneController = TextEditingController();
  //String smsCode = "123456";
  bool _isNumberGood;
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
                correctPhoneCheck(_phoneController.text);
                //_isNumberGood ? _authService.checkPhone(_phoneController.text) : showError();
                //Navigator.push(context, MaterialPageRoute(
                   // builder: (context) => VerificationScreen(_phoneController.text, _authService)));
                },
              child:CustomButton(253, 50, 10, Color(0xff56C385), Color(0xff41BFB5),Alignment.topCenter,
                  Alignment.bottomCenter, "Далее", SemiBoldText(16)),
              /*Container(
                height: 50,
                width: 253,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xff56C385), Color(0xff41BFB5)],
                  ),
                ),
                child: Text("Далее",
                    style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16)),
              ),*/
            ),
          ],
        ),
      ),
    );
  }
  correctPhoneCheck(String phoneToCheck){
    if(phoneToCheck.startsWith("+") && phoneToCheck.length >= 12 && phoneToCheck.length <= 16) {
      print("fine user");
      _isNumberGood = true;
      _authService.checkPhone(_phoneController.text);
      Navigator.push(context, MaterialPageRoute(
       builder: (context) => VerificationScreen(_phoneController.text, _authService)));
    }else{
      print("bad user");
      _isNumberGood = false;
      showError();
    }
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
                Text('Try to start with + and '),
                Text('country code'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Register'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => RegistrationScreen()));
              },
            ),
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

/*
Widget _input(String hint, TextEditingController controller, bool obscure) {
  return Container(
    height: 44,
    width: 253,
    alignment: Alignment.centerLeft,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0x3327AE63), Color(0x3327AE9E)],
      ),
    ),
    child: TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: TextInputType.number,
      style: TextStyle(fontFamily: 'Montserrat', color: Colors.white, fontSize: 16),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(12),
        isCollapsed: true,
        hintStyle: TextStyle(fontFamily: 'Montserrat', color: Colors.white, fontSize: 16, ),
        hintText: hint,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xff56C385), width: 1),
        ),
      ),
    ),
  );
}
 */