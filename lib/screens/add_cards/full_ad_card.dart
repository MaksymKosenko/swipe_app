import 'package:flutter/material.dart';
import 'package:swipe_app/global/custom_widgets/app_bars/ad_appbar.dart';
import 'package:swipe_app/models/repository/api_add.dart';

class FullAdCard extends StatefulWidget {
  ApiAdd _add;
  FullAdCard(this._add);
  @override
  _FullAdCardState createState() => _FullAdCardState();
}

class _FullAdCardState extends State<FullAdCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdAppBar(),
      body:  Container(color: Colors.white60),
    );
  }
}
