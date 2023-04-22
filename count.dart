
import 'package:flutter/material.dart';
import './main.dart';
import './photo.dart';
class NumberPage extends StatelessWidget {
  // final String responseData;
  // const NumberPage({required this.responseData});

  final String? message;
  NumberPage({required this.message});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text('Output Page'),
      ),
      body: Center(
        child: message == null
            ? const CircularProgressIndicator()
            : Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.blue,
          ),
          child: Text(
            'Count: $message',
            style: const TextStyle(fontSize: 24),
          ),
        ),
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
          ],
        ),
      ),
    );
  }
}

