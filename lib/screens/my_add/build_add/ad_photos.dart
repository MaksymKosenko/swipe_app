import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swipe_app/global/style/text_styles.dart';
import 'package:swipe_app/global/user.dart';
import 'package:swipe_app/models/add_model.dart';

class ADPhotos extends StatefulWidget {
  final ConcreteUser _user;
  final Add _add;
  ADPhotos(this._user, this._add);

  @override
  _ADPhotosState createState() => _ADPhotosState();
}

class _ADPhotosState extends State<ADPhotos> {

  List<File> photoFiles = [null, null, null, null, null, null];

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

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

  Future<void> _buildCroppingImage() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: true, //false, // user must tap button!
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: Color(0xff2E2E2E)),
              onPressed: ()=> Navigator.pop(context),),
              title: Text("Фото для объявления", style: RegularText(20, Color(0xff2E2E2E)),),
              actions: [
                _file == null? Container() : IconButton(icon: Icon(Icons.check,color: Color(0xff2E2E2E), size: 30),
                  onPressed: (){
                    _cropImage();
                    Navigator.pop(context);
                  },)
              ],
              backgroundColor: Color(0xffF5F5F5),),
            body: Column(
              children: <Widget>[
                Expanded(
                  child: Crop.file(_sample, key: cropKey),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16),
                  alignment: AlignmentDirectional.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,//spaceAround,
                    children: <Widget>[
                      TextButton(onPressed: ()=>_openImage(ImageSource.gallery), child: Text("Галерея",style: RegularText(14, Colors.black)),),
                      TextButton(onPressed: ()=>_openImage(ImageSource.camera), child: Text("Камера",style: RegularText(14, Colors.black)),),
                    ],
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          );
        });
  }


  Future<void> _buildOpenImage() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: true, //false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Выберите источник изображения",
              style: SemiBoldText(16, Colors.black),
              textAlign: TextAlign.center,
            ),
            content: Text(
                "Выберите способ ввода данных. Вы сможете сменить источник далее",
                style: RegularText(14, Colors.black)),
            actions: [
              TextButton(
                  onPressed: () {
                    _openImage(ImageSource.camera);
                    Navigator.pop(context);
                  },
                  child: Text("Камера", style: SemiBoldText(16, Colors.black))),
              TextButton(
                  onPressed: () {
                    _openImage(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                  child: Text("Галерея", style: SemiBoldText(16, Colors.black)))
            ],
          );
        });
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
    _sample == null ? null : _buildCroppingImage();
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

    if(_lastCropped != null){
      setState(() {
        photoFiles.removeAt(counter-1);
        photoFiles.insert(counter-1, _lastCropped);
        if(counter <= maxCount)
          counter++;

        widget._add.photoFiles = photoFiles;
      });
    }
    debugPrint('$file');
  }


  removePhoto(int index){
    setState(() {
      photoFiles.removeAt(index);
      photoFiles.insert(5, null);
      if(index != 5){
        counter--;
      }
      if(photoFiles[1] != null &&photoFiles[2] != null && photoFiles[3] != null
          && photoFiles[4] != null && photoFiles[5] == null){
        counter = 6;
      }
      if(counter == 0)
        counter = 1;
      print(photoFiles);
      widget._add.photoFiles = photoFiles;
    });
  }


  int counter = 1;
  int maxCount = 5;
  @override
  Widget build(BuildContext context) {
    Future<void> removeAdPhoto(String phone, String id, int index) async{
      try{
        await firebase_storage.FirebaseStorage.instance
            .ref('$phone/ads/houseImage/$id/')
            .child('photo$index')
            .delete();
        // getDownloadUrl(phone, id, 0);
      }catch (e) {
        print("error code - $e");
        // e.g, e.code == 'canceled'
      }}


    Future<void> addAdPhoto(String phone, String id, int index) async{
      try{
        await firebase_storage.FirebaseStorage.instance
            .ref('$phone/ads/houseImage/tmp/')
            .child('photo$index')
            .putFile(photoFiles[index]);

        // getDownloadUrl(phone, id, 0);
      }catch (e) {
        print("error code - $e");
        // e.g, e.code == 'canceled'
      }}

    if (widget._add.photoFiles != null){
      photoFiles[0] = widget._add.photoFiles[0];
      photoFiles[1] = widget._add.photoFiles[1];
      photoFiles[2] = widget._add.photoFiles[2];
      photoFiles[3] = widget._add.photoFiles[3];
      photoFiles[4] = widget._add.photoFiles[4];
      photoFiles[5] = widget._add.photoFiles[5];

      if(photoFiles[0] != null){
        counter = 2;
        addAdPhoto(widget._user.phone, widget._user.id, 0);
      }else removeAdPhoto(widget._user.phone, widget._user.id, 0);
      if(photoFiles[1] != null){
        counter = 3;
       addAdPhoto(widget._user.phone, widget._user.id, 1);
      }else removeAdPhoto(widget._user.phone, widget._user.id, 1);

      if(photoFiles[2] != null) {
       addAdPhoto(widget._user.phone, widget._user.id, 2);
        counter = 4;
      }else removeAdPhoto(widget._user.phone, widget._user.id, 2);
      if(photoFiles[3] != null) {
        addAdPhoto(widget._user.phone, widget._user.id, 3);
        counter = 5;
      }else removeAdPhoto(widget._user.phone, widget._user.id, 3);
      if(photoFiles[4] != null) {
        addAdPhoto(widget._user.phone, widget._user.id, 4);
        counter = 6;
      }else removeAdPhoto(widget._user.phone, widget._user.id, 4);
      if(photoFiles[5] != null) {
       addAdPhoto(widget._user.phone, widget._user.id, 5);
        counter = 6;
      }else removeAdPhoto(widget._user.phone, widget._user.id, 5);
    }

    return StaggeredGridView.countBuilder(
      padding: EdgeInsets.symmetric(horizontal: 15),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      shrinkWrap: true,
      crossAxisCount: 2,
        itemCount:counter,
        itemBuilder: (context, index){
        if(index == 0)
          return photoPicker(index);
        if(index == 1)
          return photoPicker(index);
        if(index == 2)
          return photoPicker(index);
        if(index == 3)
          return photoPicker(index);
        if(index == 4)
          return photoPicker(index);
        if(index == 5)
          return photoPicker(index);
        return Container();
        }, staggeredTileBuilder: (int index) {
        return StaggeredTile.count(1, 0.59); },
    );
/*
    if (tmp1 == null) isMainPhoto = false;
    if (tmp1 != null) isMainPhoto = true;*/

  }
  Widget photoPicker(int counter){
    //photoFiles.clear();
    print(photoFiles.length);
    print(photoFiles);
    bool concreteFileExist = false;

      if(photoFiles[counter] == null)
        print("file is not exist");
      else concreteFileExist = true;

    return Container(
          child: GestureDetector(
                onTap: () => _buildOpenImage(),// getImage("houseImage"),
                child: Stack(
                  children: [
                    Container(
                    height: 100,
                    width: 170,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xff969696)),
                      image: !concreteFileExist ? DecorationImage(
                          image: AssetImage('assets/images/plus.png'), fit: BoxFit.scaleDown)
                          :DecorationImage(
                          image: FileImage(photoFiles[counter]), fit: BoxFit.fitWidth),
                    ),
                  ),
                    Align(alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: ()=> removePhoto(counter),
                          child: !concreteFileExist ? Container():Container(
                            padding: const EdgeInsets.symmetric(vertical: 5,horizontal:8),
                            decoration: BoxDecoration(color: Colors.white70, borderRadius: BorderRadius.circular(16)),
                            child:  Icon(CupertinoIcons.delete_simple, color: Colors.red,),
                          ),
                        ),
                    ),
                  ]
                ),
              ),
          );
     // ],
    //);
  }
}
