import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import './photo.dart';
import 'dart:io';
import './main.dart';
import './boundingbox.dart';

class MyApp2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COUNTIT',
      home: BoundingBoxSelector(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BoundingBoxSelector extends StatefulWidget {
  @override
  _BoundingBoxSelectorState createState() => _BoundingBoxSelectorState();
}

class _BoundingBoxSelectorState extends State<BoundingBoxSelector> {
  final _picker = ImagePicker();
  List<Rect> _boundingBoxes = [];
  File? _image;

  void setImage(File? image) {
    _image = image;
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _boundingBoxes.clear();
      });
    }
  }

  void undo() {
    setState(() {
      _boundingBoxes.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text('Image Selector'),
      ),
      body: Column(
        children: [

          Expanded(child: GestureDetector(
            onPanDown: (details) {
              setState(() {
                _boundingBoxes.add(Rect.fromLTWH(
                  details.localPosition.dx,
                  details.localPosition.dy,
                  30,
                  30,
                ));
              });
            },
            onPanUpdate: (details) {
              setState(() {
                final lastBox = _boundingBoxes.last;
                final newBox = Rect.fromPoints(
                  lastBox.topLeft,
                  details.localPosition,
                );
                _boundingBoxes[_boundingBoxes.length - 1] = newBox;
              });
            },
            onPanEnd: (details) {
              final box = _boundingBoxes.last;
              print('New box added: $box');
            },
            child: Stack(
              children: [
                if (_image != null)
                  Image.file(
                    _image!,
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: double.infinity,
                  ),
              ],
            ),
          ),
          ),
        ],
      ),

      bottomNavigationBar: BottomAppBar(
        color: Colors.pinkAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.image),
              iconSize: 30,
              onPressed: () {
                _pickImage(ImageSource.gallery);
              },
            ),
            IconButton(
              icon: Icon(Icons.camera_alt),
              iconSize: 30,
              onPressed: () {
                _pickImage(ImageSource.camera);
              },
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              iconSize: 30,
              onPressed: () {
              Future.delayed(Duration(seconds: 1), () {
                Navigator.push(context,
                    MaterialPageRoute(builder:(context) =>  Bbpage(image: _image)));
    });
              },
            ),
          ],
        ),
      ),
    );
  }
}