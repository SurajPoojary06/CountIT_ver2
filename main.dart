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
        title: Text('CountIt',
          style: TextStyle(fontFamily: 'Montserrat',color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white70,
      ),

      body: Stack(


         // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [


            Image.asset(
                'assets/images/bg.jpg',
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
            Positioned(
              bottom: 350.0, // set the position of the button from the bottom
              right: 146.0, // set the position of the button from the right
              child: ElevatedButton(

                onPressed: () {
                  // handle button press
                  Navigator.push(context,
                      MaterialPageRoute(builder:(context) =>  MyApp()));
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white, // set the background color of the button
                ),
                child: Text('CountIt',style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Arial',
                  color: Colors.black45,
                ),),
              ),
            ),
          ],

      ),
    bottomNavigationBar: BottomAppBar(
    color: Colors.blue,
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
    IconButton(
    icon: Icon(Icons.home),
    onPressed: () {
      Navigator.push(context,
          MaterialPageRoute(builder:(context) =>  MyApp()));
    // Code to execute when home icon is pressed
    },
    ),
    IconButton(
    icon: Icon(Icons.search),
    onPressed: () {
      Navigator.push(context,
          MaterialPageRoute(builder:(context) =>  MyApp()));
    // Code to execute when search icon is pressed
    },
    ),
    IconButton(
    icon: Icon(Icons.person),
    onPressed: () {
    // Code to execute when person icon is pressed
    },
    ),
    ],
    ),
    ),
    );
  }
}



