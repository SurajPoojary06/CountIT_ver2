import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../main.dart';

class Camera extends State<MyApp>{
  File? file;
  ImagePicker image = ImagePicker();
  getCam() async {
    // ignore: deprecated_member_use
    var img = await image.getImage(source: ImageSource.camera);
    setState(() {
      file = File(img!.path);
    });
  }

  @override
   Widget build(BuildContext context) {
    // TODO: implement build
      return ElevatedButton(
        onPressed: () {
          getCam();
        },
        child: Text('Camera'),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          fixedSize: Size(100, 200),
        ),
      );
  }
}