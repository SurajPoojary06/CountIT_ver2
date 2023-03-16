import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../main.dart';

class Gallery extends State<MyApp>{
  File? file;
  ImagePicker image = ImagePicker();
  getGal() async {
    // ignore: deprecated_member_use
    var img = await image.getImage(source: ImageSource.gallery);
    setState(() {
      file = File(img!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ElevatedButton(
      onPressed: () {
        getGal();
      },
      child: Text('Camera'),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        fixedSize: Size(100, 200),
      ),
    );
  }
}