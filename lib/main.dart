
import 'dart:io';
import 'navbar.dart';
import 'details.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
      drawer: navbar(),
      appBar: AppBar(
        title: Text("CountIT"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 600,
              width: 400,
              color: Colors.black12,
              child: file == null
                  ? Icon(
                Icons.image,
                size: 70,
              )
                  : Image.file(
                file!,
                fit: BoxFit.fill,
              ),
            ),

            ElevatedButton(
              onPressed: () {
                getcam();
              },
              child: const Icon(Icons.camera_alt),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                fixedSize: Size(50, 50),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                getgall();
              },
              child: const Icon(Icons.description),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                fixedSize: Size(50, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getcam() async {
    // ignore: deprecated_member_use
    var img = await image.getImage(source: ImageSource.camera);
    setState(() {
      file = File(img!.path);
    });
  }

  getgall() async {
    // ignore: deprecated_member_use
    var img = await image.getImage(source: ImageSource.gallery);
    setState(() {
      file = File(img!.path);
    });
  }
}