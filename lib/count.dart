import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:statetry/photo.dart';
import 'dart:io';
import './main.dart';
import './photo.dart';
import './output.dart';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NumberPage extends StatefulWidget {
  final String responseData;
  const NumberPage({required this.responseData});
  @override
  _NumberPageState createState() => _NumberPageState();
}

class _NumberPageState extends State<NumberPage> {
  int? _number=10 ;

  Future<void> _fetchNumber() async {
    final response =
    await http.get(Uri.parse('https://api.example.com/number'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _number = data['number'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
  //  _fetchNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Page'),
      ),
      body: Center(
        child: _number == null
            ? const CircularProgressIndicator()
            : Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.blue,
          ),
          child: Text(
            'Number: $_number',
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}


