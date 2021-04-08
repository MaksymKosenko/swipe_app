import 'package:flutter/material.dart';
import 'package:swipe_app/global/custom_widgets/app_bars/ad_appbar.dart';
import 'package:swipe_app/models/repository/api_add.dart';

class FullAdCard extends StatefulWidget {
  ApiAdd _add;
  String _id;
  FullAdCard(this._add, this._id);
  @override
  _FullAdCardState createState() => _FullAdCardState();
}

class _FullAdCardState extends State<FullAdCard> {
  @override
  Widget build(BuildContext context) {
    print("fullAd id - ${widget._id}");
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AdAppBar(widget._id),
      ),
      body:  Container(color: Colors.white60),
    );
  }
}
