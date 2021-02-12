import 'package:firebase_auth/firebase_auth.dart';
import 'package:swipe_app/User.dart';
import 'package:swipe_app/services/databaseInteract.dart';

String currentCode;


class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool result;
  setResult(value){
    result = value;
  }

  //FirebaseAuth get firebaseAuth => _firebaseAuth;

  Future verifyPhone(String phone) async{
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) async{
        print("phone verified");
        setResult(true);
        print("result is $result");
      },
      verificationFailed: (FirebaseAuthException e) {
        setResult(false);
        print(e);
      },
      codeSent: (String verificationId, int resendToken){},
      codeAutoRetrievalTimeout: (String verificationId){},
    );
  }

  Future checkPhone(String phone) async {
    await _firebaseAuth.verifyPhoneNumber(
      //forceResendingToken: 3,
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) async{
        print("verification complete called ");
        setResult(true);
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


  void check(){
    print("****");
    print(currentCode);
    print(result);
    print("****");
  }

  Future codeCompare(String smsCode) async{
  check();
    try {
      await _firebaseAuth.signInWithCredential(PhoneAuthProvider.credential(
          verificationId: currentCode,
          smsCode: smsCode))
          .then((value) async{
        if(value.user!=null){
          //TODO:СДЕЛАТЬ ТУТ ПРОВЕРКУ, СТРОЧАКУ НИЖЕ УДАЛИТЬ НАХУЙ
          //UserActions("HUI", "KOSENKO", "EMAIL", "+11122233355").addUser();
          print(value.user.uid);
          return ConcreteUser.fromFirebase(value.user);
        }
      });
    }catch (e){
      check();
      print("We got some troubles!");
      print(e);
    }
  }



  Stream<ConcreteUser> get currentUser{
    return _firebaseAuth.authStateChanges()
        .map((User user) => user !=null ? ConcreteUser.fromFirebase(user) :null);
  }
}
