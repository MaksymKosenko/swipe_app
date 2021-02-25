import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swipe_app/basicThings/basic.dart';

class SAdCard extends StatelessWidget{
  Widget build(BuildContext context){
   String url = "https://images.unsplash.com/photo-1580587771525-78b9dba3b914?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=967&q=80";
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            width: 170,
            //decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Stack(
              children: [
              Container(
              height: 100,
              width: 170,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(fit: BoxFit.cover,
                      image: NetworkImage(url))),
              ),
               // Image.network("https://images.unsplash.com/photo-1580587771525-78b9dba3b914?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=967&q=80"),
                Positioned(
                  top: 9,right: 8,
                    child: Icon(Icons.brightness_1_outlined, color: Colors.white,),
                ),
                Positioned(
                  top: 9,left: 8,
                  child: Container(child: Text("example"), color: Colors.amberAccent,),
                ),
        ],
        ),
      ),
        SizedBox(height: 10),
        Text("3 400 000₴", style: SemiBoldText(18, Colors.black),),
        SizedBox(height: 5),
        Text("1-к квартира, 28.5 м², 1/8 эт.", style:  MediumText(12, Colors.black),),
        Text("р-н Центральный", style: MediumText(12, Color(0xff414141))),
        Text("ул. Темерязева", style: MediumText(12, Color(0xff414141))),
        SizedBox(height: 7),
        Text("Сегодня в 15:00",style: MediumText(11, Color(0xff27AEA4))),
    ]),
    );
  }
}