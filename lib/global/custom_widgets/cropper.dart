import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swipe_app/global/custom_widgets/custom_button.dart';
import 'package:swipe_app/global/style/text_styles.dart';


class Cropper extends StatefulWidget {
final String _title;
final dynamic _backScreen;
Cropper(this._title, this._backScreen);
  @override
  _CropperState createState() => new _CropperState();
}

class _CropperState extends State<Cropper> {
  final cropKey = GlobalKey<CropState>();
  File _file;
  File _sample;
  File _lastCropped;

  @override
  void dispose() {
    super.dispose();
    _file?.delete();
    _sample?.delete();
    _lastCropped?.delete();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: Color(0xff2E2E2E)),
          onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => widget._backScreen)),),
          title: Text(widget._title, style: RegularText(20, Color(0xff2E2E2E)),),
          actions: [

            _file == null? Container() : IconButton(icon: Icon(Icons.check,color: Color(0xff2E2E2E), size: 30),
              onPressed: (){
              _cropImage();
              //ProfileScreen(null).setimage(_lastCropped);
              //widget._backScreen.createState().setPhoto(_lastCropped);
              Navigator.push(context, MaterialPageRoute(builder: (context) => widget._backScreen));
              },)
          ],
        backgroundColor: Color(0xffF5F5F5),),
        body: SafeArea(
          child: Container(
            color: Colors.grey.shade300,
            padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
            child: _sample == null ? _buildOpeningImage() : _buildCroppingImage(),
          ),
        ),
      ),
    );
  }


  Widget _buildOpeningImage() {
    return Center(child: _buildOpenImage());
  }

  Widget _buildCroppingImage() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Crop.file(_sample, key: cropKey),
        ),
        Container(
          padding: const EdgeInsets.only(top: 20.0),
          alignment: AlignmentDirectional.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                child: CustomButton(70, 35, 10, Color(0xff56C387), Color(0xff42C0B5), Alignment.topCenter, Alignment.bottomCenter, "Галерея",
                    RegularText(14,Colors.white), Colors.green),
                onTap: ()=> _openImage(ImageSource.gallery),
              ),

              GestureDetector(
                child: CustomButton(70, 35, 10, Color(0xff56C387), Color(0xff42C0B5), Alignment.topCenter, Alignment.bottomCenter, "Камера",
                    RegularText(14,Colors.white), Colors.green),
                onTap: ()=> _openImage(ImageSource.camera),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildOpenImage() {
    return AlertDialog(
      title: Text("Выберите источник изображения", style: SemiBoldText(16, Colors.black),textAlign: TextAlign.center,),
      content: Text("Выберите способ ввода данных. Вы сможете сменить источник далее", style: RegularText(14, Colors.black)),
      actions: [
        TextButton(
            onPressed: (){  _openImage(ImageSource.camera);},
            child: Text("Камера",style: SemiBoldText(16, Colors.black))),
        TextButton(
            onPressed: (){ _openImage(ImageSource.gallery);},
            child: Text("Галерея", style:SemiBoldText(16, Colors.black)))
      ],
    );
  }

  Future<void> _openImage(_source) async {
    final file = await ImagePicker.pickImage(source: _source);
    final sample = await ImageCrop.sampleImage(
      file: file,
      preferredSize: context.size.longestSide.ceil(),
    );

    _sample?.delete();
    _file?.delete();

    setState(() {
      _sample = sample;
      _file = file;
    });
  }

  Future<void> _cropImage() async {
    final scale = cropKey.currentState.scale;
    final area = cropKey.currentState.area;
    if (area == null) {
      // cannot crop, widget is not setup
      return;
    }

    // scale up to use maximum possible number of pixels
    // this will sample image in higher resolution to make cropped image larger
    final sample = await ImageCrop.sampleImage(
      file: _file,
      preferredSize: (2000 / scale).round(),
    );

    final file = await ImageCrop.cropImage(
      file: sample,
      area: area,
    );

    sample.delete();

    _lastCropped?.delete();
    _lastCropped = file;

    debugPrint('$file');
    if(_lastCropped != null){
      widget._backScreen.setImage(_lastCropped);
    }

  }
}