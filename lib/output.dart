import 'package:flutter/material.dart';

class DisplayPage extends StatelessWidget {
  final List<Rect> boundingBoxes;
  DisplayPage({required this.boundingBoxes}) ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('0uput Screen'),
      ),
      body: ListView.builder(
        itemCount: boundingBoxes.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(boundingBoxes[index].toString()),
          );
        },
      ),
    );
  }
}
