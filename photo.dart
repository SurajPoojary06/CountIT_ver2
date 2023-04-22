import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';
import 'count.dart';
import 'package:http/http.dart' as http;

class imgPage extends StatelessWidget {
  File? image;
  String? message = "";
  String? code="";
  final List<Rect> boundingBoxes;

  imgPage({required this.image,required this.boundingBoxes}) ;

  uploadImage() async {
    print('working');

    final bbstr = boundingBoxes.join(",");
    //final request =  http.MultipartRequest("POST", Uri.parse("https://01de-103-89-232-73.ngrok-free.app/uploadimage"));
    final request =  http.MultipartRequest("POST", Uri.parse("https://ce2b-103-182-124-67.ngrok-free.app/uploadimage"));
    //final headersb = {"Content-type": "multipart/form-data"};
    final headers = {"Content-type": "multipart/form-data","data":bbstr};

    //final requestb =  http.MultipartRequest("POST", Uri.parse("https://cb92-2402-3a80-1929-6317-55b5-50d5-861e-f16a.ngrok-free.app//uploadbbox"));

//    final headers = ("Content-type": "multipart/form-data");

    request.files.add(http.MultipartFile('image',image!.readAsBytes().asStream(),image!.lengthSync(),
        filename: image!.path.split("/").last));

    request.headers.addAll(headers);
    final response = await request.send();
    http.Response res = await http.Response.fromStream(response);
    final resJson = jsonDecode(res.body);
    message = resJson['message'];
    print(message);
    print(response.statusCode);
    code=response.statusCode.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text('Preview Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (image != null)
              Image.file(
                image!,
                fit: BoxFit.contain,
                width: 650,
                height: 650,
              ),
            ElevatedButton(
              onPressed: ()  async {
                 await uploadImage();
                if (message != null && code== "200")
                {
                    Navigator.push(context,
                        MaterialPageRoute(builder:(context) =>  NumberPage(message: message)));
                }
                else{
                  message ="try again";
                  Navigator.push(context,
                      MaterialPageRoute(builder:(context) =>  NumberPage(message: message)));
                }
             },
              style: ElevatedButton.styleFrom(
                primary: Colors.pinkAccent, // set the background color of the button
              ),
              child: Text('COUNT',style: TextStyle(
                fontSize: 25.0, fontWeight: FontWeight.bold, fontFamily: 'Arial', color: Colors.white,
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}