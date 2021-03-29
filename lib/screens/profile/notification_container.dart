import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:swipe_app/global/style/text_styles.dart';
import 'package:swipe_app/global/user.dart';

class CustomNotification extends StatefulWidget {
  @override
  _CustomNotificationState createState() => _CustomNotificationState();
}

class _CustomNotificationState extends State<CustomNotification> {
  bool isExpandedNot = false;

  @override
  Widget build(BuildContext context) {
    final ConcreteUser user = Provider.of<ConcreteUser>(context);
    final String _documentId = user.phone;
    CollectionReference _users = FirebaseFirestore.instance.collection('users');
    DocumentReference _agent = _users
        .doc(_documentId)
        .collection("user_collections")
        .doc("Notifications");

    return FutureBuilder<DocumentSnapshot>(
        future: _agent.get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data.data();
            //_userFromFirestoreData = data;
            return Notification(data, _agent);
          }
          return isExpandedNot
              ? Container(
            height: 292,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent,
                border: Border.all(color: Color(0xffE1E1E1))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  //padding: EdgeInsets.symmetric(horizontal: 12),
                  height: 62,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 24),
                          width: 310,
                          child: Text(
                            "Уведомления",
                            style: RegularText(16, Color(0xff2E2E2E)),
                          )),
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(Icons.keyboard_arrow_up),
                        onPressed: null,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    height: 44,
                    decoration: BoxDecoration(
                      color: Color(0xffF8F8F8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Мне",
                          style: RegularText(14, Color(0xff737373)),
                        ),
                        Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                            color: Color(0xffE8E8E8),
                            borderRadius: BorderRadius.circular(7.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    height: 44,
                    decoration: BoxDecoration(
                      color: Color(0xffF8F8F8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Мне и агенту",
                          style: RegularText(14, Color(0xff737373)),
                        ),
                        Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                            color: Color(0xffE8E8E8),
                            borderRadius: BorderRadius.circular(7.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    height: 44,
                    decoration: BoxDecoration(
                      color: Color(0xffF8F8F8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Агенту",
                          style: RegularText(14, Color(0xff737373)),
                        ),
                        Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                            color: Color(0xffE8E8E8),
                            borderRadius: BorderRadius.circular(7.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    height: 44,
                    decoration: BoxDecoration(
                      color: Color(0xffF8F8F8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Отключить",
                          style: RegularText(14, Color(0xff737373)),
                        ),
                        Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                            color: Color(0xffE8E8E8),
                            borderRadius: BorderRadius.circular(7.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
              : Container(
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
                            "Уведомления",
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

  Widget Notification(status, _users) {
    changeView() {
      setState(() {
        isExpandedNot = !isExpandedNot;
        print(isExpandedNot);
      });
    }

    bool toUser = status['toUser'];
    bool toEach = status['toEach'];
    bool toAgent = status['toAgent'];
    bool disable = status['disable'];

    Future<void> setNotificationsData(
        bool disable, bool toAgent, bool toEach, bool toUser) {
      return _users
          .update({
            'disable': disable,
            'toAgent': toAgent,
            'toEach': toEach,
            'toUser': toUser,
          })
          .then((value) => print(
              "Notifications added, $disable, $toAgent, $toEach, $toUser"))
          .catchError((error) => print("Failed to add Notifications: $error"));
    }

    changeChoise(String choise) {
      if (choise == "toUser") {
        toUser = true;
        toEach = false;
        toAgent = false;
        disable = false;
        // setNotificationsData(disable, toAgent, toEach, toUser);
      }
      if (choise == "toEach") {
        toUser = false;
        toEach = true;
        toAgent = false;
        disable = false;

        // setNotificationsData(disable, toAgent, toEach, toUser);
      }
      if (choise == "toAgent") {
        toUser = false;
        toEach = false;
        toAgent = true;
        disable = false;

        // setNotificationsData(disable, toAgent, toEach, toUser);
      }
      if (choise == "disable") {
        toUser = false;
        toEach = false;
        toAgent = false;
        disable = true;
        // setNotificationsData(disable, toAgent, toEach, toUser);
      }
      setState(() {
        print("state changed");
      });
      //print("we got $toUser,$toEach,$toAgent,$disable");
      setNotificationsData(disable, toAgent, toEach, toUser);
    }

    if (isExpandedNot) {
      return Container(
        height: 292,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.transparent,
            border: Border.all(color: Color(0xffE1E1E1))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              //padding: EdgeInsets.symmetric(horizontal: 12),
              height: 62,
              child: GestureDetector(
                onTap: () => changeView(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        padding: EdgeInsets.only(left: 24),
                        width: 310,
                        child: Text(
                          "Уведомления",
                          style: RegularText(16, Color(0xff2E2E2E)),
                        )),
                    IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.keyboard_arrow_up),
                      onPressed: null,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: GestureDetector(
                onTap: () => changeChoise("toUser"),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  height: 44,
                  decoration: BoxDecoration(
                    color: Color(0xffF8F8F8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Мне",
                        style: RegularText(14, Color(0xff737373)),
                      ),
                      Container(
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                          color: toUser ? Color(0xff41BFB5) : Color(0xffE8E8E8),
                          borderRadius: BorderRadius.circular(7.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: GestureDetector(
                onTap: () => changeChoise("toEach"),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  height: 44,
                  decoration: BoxDecoration(
                    color: Color(0xffF8F8F8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Мне и агенту",
                        style: RegularText(14, Color(0xff737373)),
                      ),
                      Container(
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                          color: toEach ? Color(0xff41BFB5) : Color(0xffE8E8E8),
                          borderRadius: BorderRadius.circular(7.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: GestureDetector(
                onTap: () => changeChoise("toAgent"),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  height: 44,
                  decoration: BoxDecoration(
                    color: Color(0xffF8F8F8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Агенту",
                        style: RegularText(14, Color(0xff737373)),
                      ),
                      Container(
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                          color:
                              toAgent ? Color(0xff41BFB5) : Color(0xffE8E8E8),
                          borderRadius: BorderRadius.circular(7.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: GestureDetector(
                onTap: () => changeChoise("disable"),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  height: 44,
                  decoration: BoxDecoration(
                    color: Color(0xffF8F8F8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Отключить",
                        style: RegularText(14, Color(0xff737373)),
                      ),
                      Container(
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                          color:
                              disable ? Color(0xff41BFB5) : Color(0xffE8E8E8),
                          borderRadius: BorderRadius.circular(7.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return GestureDetector(
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
                  child: Text(
                    "Уведомления",
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
}
