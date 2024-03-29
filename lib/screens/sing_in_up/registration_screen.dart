import 'package:flutter/material.dart';
import 'package:swipe_app/global/custom_widgets/logo.dart';
import 'package:swipe_app/global/style/gradients.dart';
import 'package:swipe_app/services/databaseInteract.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _surController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  bool isCheck = false;
  bool _isNameGood;
  bool _isSurNameGood;
  bool _isEmailGood;
  @override
  Widget build(BuildContext context) {

    return Material(
      child: Container(
        decoration: GradientBack(),
        child: Column(
          children: [
            SizedBox(height: 166),
            Logo(41.62, 62, 42, 15),
            SizedBox(height: 40),
            _input("Имя", _nameController, false),
            SizedBox(height: 25),
            _input("Фамилия", _surController, false),
            SizedBox(height: 25),
            _input("Телефон", _phoneController, false),
            SizedBox(height: 25),
            _input("Email", _emailController, false),
            SizedBox(height: 40),
            Row(
              children: [
                SizedBox(width: 32),
                Container(
                  width: 22,
                  height: 22,
                  child: Checkbox(
                    value: isCheck,
                    onChanged: (bool value) {
                      setState(() {
                        isCheck = value;
                      });
                    },
                  checkColor: Colors.white  ,
                  activeColor: Color(0xff56C385),
                  ),
                ),
                SizedBox(width: 16),
                Container(
                  height: 55,
                  width: 273,
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Я прочитал(-а)  и согласен(-на) с",
                          style: TextStyle(fontFamily: 'Montserrat', fontSize: 14, color: Colors.white)),
                      Text("Политикой конфиденциальности и",
                          style: TextStyle(fontFamily: 'Montserrat', fontSize: 14, color: Colors.white)),
                      Text("Условиями использования.",
                          style: TextStyle(fontFamily: 'Montserrat', fontSize: 14, color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Container(
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
              child: GestureDetector(
                child: Text("Далее",
                    style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16)),
                onTap: (){
                  var userActions = UserActions(_nameController.text, _surController.text, _emailController.text, _phoneController.text, context);
                  correctDataCheck(_nameController.text, _surController.text, _emailController.text, userActions);
                }
              ),
            ),
          ],
        ),
      ),
    );
  }

  correctDataCheck(String nameToCheck,String surNameToCheck, String emailToCheck, userActions){
    String unwantedNameSymbols = "[]{}<>|`₴'1234567890!@#%^&*()_+-=^/№;%:? ";
    String unwantedEmailSymbols = "[]{}<>|`₴'!#%^&*()+=^/№;%:? ";
    if(nameToCheck.isNotEmpty && !nameToCheck.contains(unwantedNameSymbols) &&
        surNameToCheck.isNotEmpty && !surNameToCheck.contains(unwantedNameSymbols)){
      _isNameGood = true;
      _isSurNameGood = true;
    }else showError("wrong name or surname");
    if(emailToCheck.length>4 && emailToCheck.contains("@") && emailToCheck.contains(".") && !emailToCheck.contains(unwantedEmailSymbols)){
      _isEmailGood = true;
    }else showError("Wrong Email");


    if(_isNameGood == true && _isSurNameGood == true && _isEmailGood == true && isCheck == true){
      userActions.isExist();
    }
  }

  Future <void> showError(String errorText) async{
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Registration error'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(errorText),
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
      style: TextStyle(fontFamily: 'Montserrat', color: Colors.white, fontSize: 16),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(12),
        isCollapsed: true,
        hintStyle: TextStyle(fontFamily: 'Montserrat', color: Colors.white, fontSize: 16),
        hintText: hint,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xff56C385), width: 1),
            ),
      ),
    ),
  );
}
