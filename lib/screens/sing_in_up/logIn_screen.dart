import 'package:flutter/material.dart';
import 'package:swipe_app/global/custom_widgets/custom_button.dart';
import 'package:swipe_app/global/custom_widgets/custom_input.dart';
import 'package:swipe_app/global/custom_widgets/logo.dart';
import 'package:swipe_app/global/style/gradients.dart';
import 'package:swipe_app/global/style/text_styles.dart';
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
            SizedBox(height: 72),
            input(253, 44, _phoneController, false, TextInputType.phone,
            RegularText(16, Colors.white), RegularText(16, Colors.white), "Телефон", Color(0xff56C385)),
            SizedBox(height: 25),
            GestureDetector(
              onTap: (){
                var _phoneToCheck = _phoneController.text;
                _authService.isExist(_phoneToCheck, context);
                },
              child:CustomButton(253, 50, 10, Color(0xff56C385), Color(0xff41BFB5),Alignment.topCenter,
                  Alignment.bottomCenter, "Далее", SemiBoldText(16, Colors.white), Colors.transparent),
            ),
          ],
        ),
      ),
    );
  }
}
