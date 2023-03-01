
import 'package:flutter/material.dart';
import './navbar.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      // drawer: Drawer(),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'CountIT - A diverse object Counting Application from a scene using Computer Vision',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

