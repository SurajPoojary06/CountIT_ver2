
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'info.dart';


//Main (First) Page
void main() {
  runApp(const MaterialApp(
    title: 'count',
    home: FirstRoute(),
    debugShowCheckedModeBanner: false,
  ));
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});


  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('COUNTIT'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            ElevatedButton(
              child: const Text('CountIt'),
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





