import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_app/global/custom_widgets/app_bars/default_app_bar.dart';
import 'package:swipe_app/global/custom_widgets/custom_button.dart';
import 'package:swipe_app/global/style/text_styles.dart';
import 'package:swipe_app/models/filters_model.dart';
import 'package:swipe_app/screens/feed/landing_page.dart';
import 'package:swipe_app/screens/filters_screen/filters_input.dart';
import 'package:swipe_app/screens/filters_screen/filters_rooms_quantity.dart';

class FilteredAdsScreen extends StatefulWidget {
  @override
  _FilteredAdsScreenState createState() => _FilteredAdsScreenState();
}

class _FilteredAdsScreenState extends State<FilteredAdsScreen> {
  bool isExpandedPrice1 = false;
  bool isExpandedPrice2 = false;
  bool isExpandedOverallArea1 = false;
  bool isExpandedOverallArea2 = false;
  bool isExpandedKitchenArea1 = false;
  bool isExpandedKitchenArea2 = false;
  bool isExpandedRooms = false;

  TextEditingController _priceController1 = TextEditingController();
  TextEditingController _priceController2 = TextEditingController();
  TextEditingController _overallAreaController1 = TextEditingController();
  TextEditingController _overallAreaController2 = TextEditingController();
  TextEditingController _kitchenAreaController1 = TextEditingController();
  TextEditingController _kitchenAreaController2 = TextEditingController();


  Filter _filter = Filter();
 /* void changeView(String data){
    switch(data){
      case "isExpandedRooms" : setState(() {isExpandedRooms = !isExpandedRooms;});
    }
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar("Фильтры", 82, MaterialPageRoute(builder: (context)=> LandingPage())),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Цена", style: SemiBoldText(14, Color(0xff2E2E2E)),),
                SizedBox(height: 10),
                Container(height: 44, width: double.maxFinite,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0x32DADADA)),
                  child: FiltersInput(_filter, _priceController1, "От 20 000₴"),),
                SizedBox(height: 10),
                Container(height: 44, width: double.maxFinite,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0x32DADADA)),
                  child: FiltersInput(_filter, _priceController2, "До 50 000₴"),),
              ],
            ),
            SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Общая площадь", style: SemiBoldText(14, Color(0xff2E2E2E)),),
                SizedBox(height: 10),
                Container(height: 44, width: double.maxFinite,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0x32DADADA)),
                child: FiltersInput(_filter, _overallAreaController1, "От 70М\u{00B2}"),),
                SizedBox(height: 10),
                Container(height: 44, width: double.maxFinite,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0x32DADADA)),
                  child: FiltersInput(_filter, _overallAreaController2, "До 120М\u{00B2}"),),
              ],
            ),
            SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Площадь кухни", style: SemiBoldText(14, Color(0xff2E2E2E)),),
                SizedBox(height: 10),
                Container(height: 44, width: double.maxFinite,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0x32DADADA)),
                  child: FiltersInput(_filter, _kitchenAreaController1, "От 20М\u{00B2}"),),
                SizedBox(height: 10),
                Container(height: 44, width: double.maxFinite,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0x32DADADA)),
                  child: FiltersInput(_filter, _kitchenAreaController2, "До 50М\u{00B2}"),),
              ],
            ),
            SizedBox(height: 30),
            FiltersRoomQuantity(_filter),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: GestureDetector(
                onTap: () {
                  print("test");
                  print(_filter.priceLow);
                  print(_filter.priceHigh);
                  print(_filter.overallAreaLow);
                  print(_filter.overallAreaHigh);
                  print(_filter.kitchenAreaLow);
                  print(_filter.kitchenAreaHigh);
                  print(_filter.roomsQuantity);
                },
                child: CustomButton(278, 52, 35, Color(0xff56C385), Color(0xff41BFB5), Alignment.topCenter, Alignment.bottomCenter,
                    "Показать квартиры", SemiBoldText(16, Colors.white), Colors.transparent),
              ),
            )
          ],
        ),
      ),
    );
  }
}
