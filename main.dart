import 'package:flutter/material.dart';
import 'dart:io';
import 'info.dart';
import 'dart:async';

void main() {
  runApp(MaterialApp(
    title: 'CountIT Application',
    home: MyApp(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(),
  ));
}

// Create a new stateless widget for the splash screen
class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/app_icon_1.jpeg',
          fit: BoxFit.cover,
          height: 400,
          width: 300,
        ),
      ),
    );
  }
}
// Create a new stateless widget for the home screen
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Set the background color of the home screen
    return Container(
      color: Colors.white,
      child: Center(
        child: Text(
          'Home Screen',
          style: TextStyle(
            fontSize: 30.0,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}

// Create a new stateful widget for the app
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

// Create a new state for the app
class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Wait for 3 seconds and then navigate to the home screen
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BoundingBoxSelector()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Show the splash screen while waiting to navigate to the home screen
    return SplashScreen();
  }
}
