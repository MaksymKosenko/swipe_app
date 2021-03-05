import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swipe_app/basicThings/AdDataKeeper.dart';
import 'package:swipe_app/basicThings/User.dart';
import 'package:swipe_app/basicThings/basic.dart';

class ADPhotos extends StatefulWidget {
  final ConcreteUser _user;
  final ConcreteAd _concreteAd;
  ADPhotos(this._user, this._concreteAd);

  @override
  _ADPhotosState createState() => _ADPhotosState();
}

class _ADPhotosState extends State<ADPhotos> {
  bool isMainPhoto = false;
  bool isAdditionalPhoto = false;
  String mainPhoto;
  String additionalPhoto;
  File tmp1;
  File tmp2;
  File _image;
  final picker = ImagePicker();

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future getImage(String type) async {
    final pickedFile = await picker.getImage(
        source:
            ImageSource.gallery); //ImageSource.gallery);//ImageSource.camera);
      if (pickedFile != null) {
          _image = File(pickedFile.path);
          storage.ref().child(widget._user.phone).child(type).putFile(_image);
            downloadURL(type);
          setState(() {
            switch (type) {
              case "houseImage":tmp1 = _image; break;
              case "additionalImage":tmp2 = _image;break;
            }
          });
      } else {
        print('No image selected.');
      }

  }

  Future<void> downloadURL(String type) async {
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref("${widget._user.phone}/$type")
        .getDownloadURL();
      switch (type) {
        case "houseImage":mainPhoto = downloadURL; widget._concreteAd.setMainPhotoPath(mainPhoto);break;
        case "additionalImage":additionalPhoto = downloadURL;widget._concreteAd.setAdditionalPhotosPath(additionalPhoto);break;
      }

  }

  @override
  Widget build(BuildContext context) {

    /*
    if (mainPhoto == null) isMainPhoto = false;
    if (mainPhoto != null) isMainPhoto = true;
    if (additionalPhoto == null) isAdditionalPhoto = false;
    if (additionalPhoto != null) isAdditionalPhoto = true;*/
    if (tmp1 == null) isMainPhoto = false;
    if (tmp1 != null) isMainPhoto = true;
    if (tmp2 == null) isAdditionalPhoto = false;
    if (tmp2 != null) isAdditionalPhoto = true;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Text(
            "Главное фото",
            style: RegularText(12, Color(0xff737373)),
          ),
        ),
        SizedBox(height: 7),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => getImage("houseImage"),
                child: isMainPhoto
                    ? Container(
                        height: 100,
                        width: 170,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Color(0xff969696)),
                          image: DecorationImage(
                              image: FileImage(tmp1), fit: BoxFit.fill),//NetworkImage(mainPhoto), fit: BoxFit.fill),
                        ),
                      )
                    : Container(
                        height: 100,
                        width: 170,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Color(0xff969696)),
                        ),
                        child: Icon(
                          CupertinoIcons.plus,
                          size: 54,
                        ),
                      ),
              ),
              GestureDetector(
                onTap: () => getImage("additionalImage"),
                child: isAdditionalPhoto
                    ? Container(
                        height: 100,
                        width: 170,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Color(0xff969696)),
                          image: DecorationImage(
                              image: FileImage(tmp2), fit: BoxFit.fill),//image: NetworkImage(additionalPhoto), fit: BoxFit.fill),
                        ),
                      )
                    : Container(
                        height: 100,
                        width: 170,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Color(0xff969696)),
                        ),
                        child: Icon(
                          CupertinoIcons.plus,
                          size: 54,
                        ),
                      ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
