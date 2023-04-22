import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './info.dart';
import './photo.dart';
import './main.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui' as ui;
import 'package:flutter_image_compress/flutter_image_compress.dart';


class Bbpage extends StatefulWidget {
  File? image;
  Bbpage({required this.image});
  @override
  Bbbox createState() => Bbbox(image: image);
}

class Bbbox extends State<Bbpage> {
  List<Rect> _boundingBoxes = [];
  File? image;
  File? reimage;
  // GlobalKey _imageKey = GlobalKey();
  Bbbox({required this.image});
  void undo() {
    setState(() {
      _boundingBoxes.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    resizeImage(image!).then((file) {
      setState(() {
        reimage = file;
      });
    });
  }
  Future<File> resizeImage(File file) async {
    final result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minHeight: 393,
      minWidth: 393,
      quality: 100,
    );
    final compressedFile = File(file.path)..writeAsBytesSync(result!);
    return compressedFile;
  }
  //resizeImage()
  void widthundo() async{
    var decodedImage = await decodeImageFromList(reimage!.readAsBytesSync());
    print('bbox:$decodedImage.width');
    print('bbox:$decodedImage.height');
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text('Select Bounding Boxes'),
      ),
      body: Column(
        children: [
          Expanded(child: GestureDetector(
            onPanDown: (details) {
              final imageBox = context.findRenderObject() as RenderBox;
              final imagePosition = imageBox.localToGlobal(Offset.zero);
              final box = Rect.fromLTWH(
                details.localPosition.dx - imagePosition.dx,
                details.localPosition.dy - imagePosition.dy,
                30,
                30,
              );
              setState(() {
                _boundingBoxes.add(box);
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
              print('******************');
              print('New box added: $box');
            },
            child: Stack(
              children: [
                if (reimage != null)
                  Image.file(
                    reimage!,
                    fit: BoxFit.fill,
                    // height: null,
                    // width: null,
                    //height: MediaQuery.of(context).size.height *0.5,
                    //width: MediaQuery.of(context).size.width,
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
        tooltip: 'BoundingBox Remover',
        child: Icon(Icons.edit),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.pinkAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              iconSize: 30,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder:(context) =>  MyApp()));
              },
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              iconSize: 30,
              onPressed: () {
                widthundo();
                Navigator.push(context,
                    MaterialPageRoute(builder:(context) =>  imgPage(image: reimage,boundingBoxes: _boundingBoxes)));
              },
            ),
          ],
        ),
      ),
    );
  }
}