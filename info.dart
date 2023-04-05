
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:statetry/output.dart';
import 'dart:io';
import './main.dart';


//Second Page
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

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _boundingBoxes.clear();
      });
    }
  }

 //Undo Button code
  void _undo() {
    setState(() {
      _boundingBoxes.clear();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bounding Box Selector'),
      ),
      body: GestureDetector(
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
          print('New box added: $box'); //Displays the BB details as a list in the terminal
        },
        child: Stack(
          children: [
            if (_image != null)
              Image.file(
                _image!,
                fit: BoxFit.cover,
                // width: double.infinity,
                // height: double.infinity,
                width: 500,
                height: 600,
              ),
            ..._boundingBoxes.map((box) {
              return Positioned.fromRect(
                rect: box,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              );
            }),
          ],
        ),
      ),



      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text('Take a picture'),
                    onTap: () {
                      Navigator.pop(context);
                      _pickImage(ImageSource.camera);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.image),
                    title: Text('Choose from gallery'),
                    onTap: () {
                      Navigator.pop(context);
                      _pickImage(ImageSource.gallery);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.remove),
                    title: Text('Remove Bounding Boxes'),
                    onTap: () {
                      _undo();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.arrow_forward),
                    title: Text('Confirm'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder:(context) =>  DisplayPage()));
                    },
                  ),
                ],
              );
            },
          );
        },
        tooltip: 'Select Image',
        child: Icon(Icons.add),
      ),
    );
  }
}
