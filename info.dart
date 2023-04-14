import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:statetry/photo.dart';
import 'dart:io';
import './main.dart';

class MyApp extends StatelessWidget {

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
                if (_image != null)
                  Image.file(
                    _image!,
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
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // ListTile(
                  //   leading: Icon(Icons.camera_alt),
                  //   title: Text('Take a picture'),
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //     _pickImage(ImageSource.camera);
                  //   },
                  // ),
                  // ListTile(
                  //   leading: Icon(Icons.image),
                  //   title: Text('Choose from gallery'),
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //     _pickImage(ImageSource.gallery);
                  //   },
                  // ),
                  ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Remove Bounding Boxes'),
                    onTap: () {
                      undo();
                      Navigator.pop(context);
                    },
                  ),
                  // ListTile(
                  //   leading: Icon(Icons.arrow_forward),
                  //   title: Text('Process'),
                  //   onTap: () {
                  //     Navigator.push(context,
                  //         MaterialPageRoute(builder:(context) => DisplayPage(boundingBoxes: _boundingBoxes)));
                  //   },
                  // ),
                  // ListTile(
                  //   leading: Icon(Icons.archive_outlined),
                  //   title: Text('Image'),
                  //   onTap: () {
                  //     Navigator.push(context,
                  //         MaterialPageRoute(builder:(context) => imgPage(image: _image,boundingBoxes: _boundingBoxes)));
                  //   },
                  // ),
                  ListTile(
                    leading: Icon(Icons.archive_outlined),
                    title: Text('Upload'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder:(context) => imgPage(image: _image,boundingBoxes: _boundingBoxes)));
                    },
                  // ),ListTile(
                  //   leading: Icon(Icons.output),
                  //   title: Text('count'),
                  //   onTap: () {
                  //     Navigator.push(context,
                  //         MaterialPageRoute(builder:(context) => const NumberPage()));
                  //   },
                  // ),
                  ),],
              );
            },
          );
        },
        tooltip: 'Select Image',
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
                    MaterialPageRoute(builder:(context) =>  FirstRoute()));
                // Code to execute when home icon is pressed
              },
            ),
            IconButton(
              icon: Icon(Icons.camera_alt),
              iconSize: 30,
              onPressed: () {

                _pickImage(ImageSource.camera);
                // Code to execute when search icon is pressed
              },
            ),
            IconButton(
              icon: Icon(Icons.image),
              iconSize: 30,
              onPressed: () {
                _pickImage(ImageSource.gallery);
                // Code to execute when person icon is pressed
              },
            ),
          ],
        ),
      ),
    );
  }
}
