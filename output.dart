
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'info.dart';


// //Main (First) Page
void main() {
  runApp(const MaterialApp(
    title: 'count',
    home: DisplayPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class DisplayPage extends StatelessWidget {
  const DisplayPage({super.key});



  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('COUNT DISPLAY'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            ElevatedButton(
              child: const Text('count'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder:(context) =>  MyApp()));
              },
            ),
          ],
        ),
      ),
    );
  }
}






