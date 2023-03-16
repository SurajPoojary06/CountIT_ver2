import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/Camera.dart';

import 'camera/Camera.dart';
import 'gallery/Gallery.dart';
void main() {
  runApp(k());
}

class k extends StatefulWidget {
  @override
  _kState createState() => _kState();
}

class _kState extends State<k> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  File? file;
  ImagePicker image = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WebFun"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 140,
              width: 180,
              color: Colors.black12,
              child: file == null
                  ? const Icon(
                Icons.image,
                size: 50,
              )
                  : Image.file(
                file!,
                fit: BoxFit.fill,
              ),
            ),

            // MaterialButton(
            //   onPressed: () {
            //     getgall();
            //   },
            //   color: Colors.blue[600],
            //   shape: ,
            //
            //   child: Text(
            //     "take from gallery",
            //     style: TextStyle(
            //       color: Colors.white,
            //     ),
            //   ),
            // ),

            ElevatedButton(
              onPressed: () {
                Gallery().getGal();
              },
              child: Text('Gallery'),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                fixedSize: Size(100, 200),
              ),
            ),

            MaterialButton(
              onPressed: () {
                Camera().getCam();
              },
              color: Colors.blue[900],
              child: Text(
                "take from camera",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}