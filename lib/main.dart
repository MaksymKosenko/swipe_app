import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_app/global/custom_widgets/custom_button.dart';
import 'package:swipe_app/global/custom_widgets/logo.dart';
import 'package:swipe_app/global/style/gradients.dart';
import 'package:swipe_app/global/style/text_styles.dart';
import 'package:swipe_app/global/user.dart';
import 'package:swipe_app/screens/sing_in_up/logIn_screen.dart';
import 'package:swipe_app/screens/sing_in_up/registration_screen.dart';
import 'package:swipe_app/services/auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(SwipeApp());
}

class SwipeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<ConcreteUser>.value(
      value: AuthService().currentUser,
        child: MaterialApp(
            title: 'Swipe App',
            home: Material(child: HomePage())));
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: GradientBack(),
      child: Column(
        children: [
          SizedBox(height: 166),
          Logo(41.62, 62, 42, 15),
          SizedBox(height: 40),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 85),
            child: Column(
              children: [
                Text("Открой доступ к самой", style: RegularText(14, Colors.white)),
                Text("полной базе рынка", style: RegularText(14, Colors.white)),
                Text("квартир в Сочи!", style: RegularText(14, Colors.white)),
              ],
            ),
          ),
          SizedBox(height: 50.5),
          GestureDetector(
            child: CustomButton(253, 50, 10, Color(0xff56C385), Color(0xff41BFB5), Alignment.topCenter, Alignment.bottomCenter, "Войти", SemiBoldText(16, Colors.white), Colors.transparent),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen())),
          ),
          SizedBox(height: 20),
          Container(
            height: 16,
            width: 215,
            child: Row(
              children: [
                Text("Впервые у нас?", style: RegularText(13, Colors.white60)),
                SizedBox(width: 10),
                GestureDetector(
                  child: Text("Регистрация", style: SemiBoldText(13, Colors.white)),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegistrationScreen())),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
