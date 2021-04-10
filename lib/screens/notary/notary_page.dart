import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swipe_app/global/custom_widgets/app_bars/default_app_bar.dart';
import 'package:swipe_app/global/style/text_styles.dart';
import 'package:swipe_app/screens/feed/landing_page.dart';
import 'package:url_launcher/url_launcher.dart';

class NotaryScreen extends StatefulWidget {
  @override
  _NotaryScreenState createState() => _NotaryScreenState();
}

class _NotaryScreenState extends State<NotaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar("Нотариусы", 82,
        MaterialPageRoute(builder: (context) => LandingPage()),),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: StreamBuilder(

            stream: FirebaseFirestore.instance.collection('notary').snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              var data;
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              if (snapshot.connectionState == ConnectionState.active) {
                data = snapshot.data;
                print("datadocslength - ${data.docs.length}");
                return ListView.builder(
                  itemCount: data.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                   return Container(
                     height: 80,
                     child: Align(
                       alignment: Alignment.topCenter,
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Align(
                             alignment: Alignment.centerLeft,
                             child: Row(
                               children:[
                                 Container(
                                   height: 60,
                                   width: 60,
                                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                                       image: DecorationImage(image: NetworkImage(data.docs[index]['photoPath']),fit: BoxFit.fill)),
                                 ),
                                 SizedBox(width: 20),
                                 Column(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Text("${data.docs[index]['name']} ${data.docs[index]['surName']}",style: MediumText(16, Colors.black),),
                                     Text("${data.docs[index]['phone']}",style: RegularText(12, Color(0xff494949)),),
                                     Text("${data.docs[index]['email']} ${data.docs[index]['surName']}",style: RegularText(12, Color(0xff494949)),)
                                   ],
                                 ),
                               ],
                             ),
                           ),


                           Align(alignment: Alignment.centerRight,
                               child: IconButton(icon: Icon(Icons.phone_in_talk_outlined, color: Color(0xff41BFB5), size: 26,),
                                   onPressed: ()=> launch('tel:${data.docs[index]['phone']}'),))
                         ],
                       ),
                     ),
                   );
                  },
                );
              }
              print("length for use - ${data.docs.length}");
              return Container();
            }),
      ),
    );
  }
}
