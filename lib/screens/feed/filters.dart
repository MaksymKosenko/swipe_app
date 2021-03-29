import 'package:flutter/material.dart';
import 'package:swipe_app/global/style/text_styles.dart';

class CustomFilters extends StatefulWidget{
  @override
  _CustomFiltersState createState() => _CustomFiltersState();
}

class _CustomFiltersState extends State<CustomFilters> {
  bool _active1 = false;
  bool _active2 = false;
  bool _active3 = true;
  bool _active4 = false;

  Widget build(BuildContext context){
    return Container(
      height: 32,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 12),
        scrollDirection: Axis.horizontal,
        children: [
          _active1 ? choosedFilter("Вторичный рынок", "_active1") : unChoosedFilter("Вторичный рынок", "_active1"),
          SizedBox(width: 15),
          _active2 ? choosedFilter("Новостройки", "_active2") : unChoosedFilter("Новостройки", "_active2"),
          SizedBox(width: 15),
          _active3 ? choosedFilter("Все", "_active3") : unChoosedFilter("Все", "_active3"),
          SizedBox(width: 15),
          _active4 ? choosedFilter("Котеджи", "_active4") : unChoosedFilter("Котеджи", "_active4"),
        ],
      ),
    );
  }

  Widget choosedFilter(String text, String currentState){
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xff56C385), Color(0xff41BFB5)],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextButton(onPressed:()=> setActive(currentState), child: Text(text, style: RegularText(14, Colors.white),overflow: TextOverflow.visible))/*Text(text, style: RegularText(14, Colors.white),))  */);
  }

  Widget unChoosedFilter(String text, String currentState){
    return Container(padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xff27AEA4)),
        ),
        child: TextButton(onPressed:()=>setActive(currentState), child: Text(text, style: RegularText(14, Color(0xff27AEA4)),overflow: TextOverflow.visible)));
  }

  void setActive(String currentState){
    setState(() {
      switch(currentState){
        case "_active1" : _active1 = true; _active2 = false; _active3 = false; _active4 = false; break;
        case "_active2" : _active1 = false; _active2 = true; _active3 = false; _active4 = false; break;
        case "_active3" : _active1 = false; _active2 = false; _active3 = true; _active4 = false; break;
        case "_active4" : _active1 = false; _active2 = false; _active3 = false; _active4 = true; break;
      }
    });
  }
}