import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:statetry/info.dart';
import 'package:statetry/photo.dart';

class Bbpage extends StatefulWidget {
  File? image;
  Bbpage({required this.image});
  @override
  Bbbox createState() => Bbbox(image: image);
}

class Bbbox extends State<Bbpage> {
  List<Rect> _boundingBoxes = [];
  File? image;

  Bbbox({required this.image});

  void undo() {
    setState(() {
      _boundingBoxes.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.pinkAccent,
        //   title: Text('Bounding Box Selector'),
        // ),
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
    // Image.asset(
    //   'assets/images/bg.jpg',
    //   fit: BoxFit.cover,
    //   height: double.infinity,
    //   width: double.infinity,
    // ),
    if (image != null)
    Image.file(
    image!,
    fit: BoxFit.cover,
    width: double.infinity,
    height: double.infinity,
    // width: 500,
    //height: 650,
    ),
    ..._boundingBoxes.map((box) {
    return Positioned.fromRect(
    rect: box,
    child: Container(
    decoration: BoxDecoration(
    border: Border.all(color: Colors.black, width: 2),
    ),
    ),
    );
    }),
    ],
    ),
    ),
    ),
    ],
    ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
    undo();
    },
        tooltip: 'Remove BoundingBox',
        child: Icon(Icons.edit),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.pinkAccent,
        height:65,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              iconSize: 30,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder:(context) =>  MyApp()));
                // Code to execute when home icon is pressed
              },
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              iconSize: 30,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder:(context) =>  imgPage(image: image,boundingBoxes: _boundingBoxes)));
                // Code to execute when home icon is pressed
              },
            ),

          ],
        ),
      ),

    );
}



}