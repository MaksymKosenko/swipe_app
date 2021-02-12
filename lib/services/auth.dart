import 'package:firebase_auth/firebase_auth.dart';
import 'package:swipe_app/User.dart';

String currentCode;


class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future checkPhone(String phone) async {
    await _firebaseAuth.verifyPhoneNumber(
      //forceResendingToken: 3,
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) async{
        print("verification complete called ");
        await _firebaseAuth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int resendToken) async{
        currentCode = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        currentCode = verificationId;
      },
    );
  }

  Future codeCompare(String smsCode) async{
    try {
      await _firebaseAuth.signInWithCredential(PhoneAuthProvider.credential(
          verificationId: currentCode,
          smsCode: smsCode))
          .then((value) async{
        if(value.user!=null){
          print(value.user.uid);
          return ConcreteUser.fromFirebase(value.user);
        }
      });
    }catch (e){
      print("We got some troubles!");
      print(e);
    }
  }



  Stream<ConcreteUser> get currentUser{
    return _firebaseAuth.authStateChanges()
        .map((User user) => user !=null ? ConcreteUser.fromFirebase(user) :null);
  }
}
