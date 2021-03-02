import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_app/basicThings/User.dart';
import 'package:swipe_app/basicThings/basic.dart';

class CustomSubscription extends StatefulWidget {
  @override
  _CustomSubscriptionState createState() => _CustomSubscriptionState();
}

class _CustomSubscriptionState extends State<CustomSubscription> {
  bool isExpandedSub = false;

  @override
  Widget build(BuildContext context) {
    final ConcreteUser user = Provider.of<ConcreteUser>(context);
    final String _documentId = user.phone;
    CollectionReference _users = FirebaseFirestore.instance.collection('users');
    DocumentReference _agent =
        _users.doc(_documentId).collection("user_collections").doc("Subscribe");
    // var test = _agent.get();
    return FutureBuilder<DocumentSnapshot>(
        future: _agent.get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data.data();
            //_userFromFirestoreData = data;
            return Subscription(data);
          }
          return Container(
            height: 64,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent,
                border: Border.all(color: Color(0xffE1E1E1))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: EdgeInsets.only(left: 24),
                    child: Text(
                      "Управление подпиской",
                      style: RegularText(16, Color(0xff2E2E2E)),
                    )),
                IconButton(
                  icon: Icon(Icons.keyboard_arrow_down),
                  onPressed: null,
                ),
              ],
            ),
          );
        });
  }

  Widget Subscription(status) {
    changeView() {
      setState(() {
        isExpandedSub = !isExpandedSub;
        print(isExpandedSub);
      });
    }
    String _endData = status['endData'];
    if (_endData =="null")
      _endData = "подписка не оформлена";

    bool _autoSubscribe = status['autoSubscribe'];
    return isExpandedSub
        ? Container(
            height: 228,
            //padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent,
                border: Border.all(color: Color(0xffE1E1E1))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 62,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 24),
                          width: 310,
                          child: Text(
                            "Управление подпиской",
                            style: RegularText(16, Color(0xff2E2E2E)),
                          )),
                      IconButton(
                        icon: Icon(Icons.keyboard_arrow_up),
                        onPressed: () => changeView(),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 30),
                Container(
                  padding: EdgeInsets.only(left: 24),
                  height: 17,
                  child: Row(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Оплачено до",
                          style: RegularText(14, Color(0xff606060))),
                      SizedBox(width: 14),
                      Text(_endData,
                          style: MediumText(14, Color(0xff41BFB5))),
                      //TODO закончить кнопки и их связь с бд
                    ],
                  ),
                ),
                SizedBox(height: 35),
                Container(
                  alignment: Alignment.center,
                  child: CustomButton(
                      307,
                      45,
                      10,
                      Color(0xff56C486),
                      Color(0xff42C0B5),
                      Alignment.centerLeft,
                      Alignment.centerRight,
                      "Продлить",
                      SemiBoldText(14, Colors.white),
                      Color(0xff56C385)),
                ),
                SizedBox(height: 15),
                Container(
                    alignment: Alignment.center,
                    child: Text("Отменить автопродление",
                        style: MediumText(12, Color(0xff575757)))),
              ],
            ),
          )
        : GestureDetector(
            child: Container(
              height: 64,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.transparent,
                  border: Border.all(color: Color(0xffE1E1E1))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 24),
                      width: 310,
                      child: Text(
                        "Управление подпиской",
                        style: RegularText(16, Color(0xff2E2E2E)),
                      )),
                  IconButton(
                    icon: Icon(Icons.keyboard_arrow_down),
                    onPressed: null,
                  ),
                ],
              ),
            ),
            onTap: () => changeView(),
          );
  }
}
