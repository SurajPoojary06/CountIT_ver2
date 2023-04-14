import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './output.dart';
import 'package:statetry/count.dart';



class imgPage extends StatelessWidget {
  late final response;
  File? image;
  String? message = "";
  final List<Rect> boundingBoxes;

  imgPage({required this.image,required this.boundingBoxes}) ;

  // Future<void> writeToFile(List<Rect> boundingBoxes) async {
  //   final file = File('C:\\Users\\shreyas kv\\AndroidStudioProjects\\labproj\\statetry\\lib\\bbfiles\\file.txt');
  //   await file.writeAsString(boundingBoxes.join('\n'));
  // }


  uploadImage() async {
    print('working');
    //writeToFile(boundingBoxes);
 //   final File BBfile=File('C:\\Users\\shreyas kv\\AndroidStudioProjects\\labproj\\statetry\\lib\\bbfiles\\bbox');
   // final file = File();
    //await file.writeAsString(rectListAsString);
    // final request =  http.MultipartRequest("POST", Uri.parse("https://ff18a504f21a.ngrok.io/upload"));
    final bbstr=boundingBoxes.join(",");
    final request =  http.MultipartRequest("POST", Uri.parse("https://4076-2402-8100-25d6-e2e6-84df-5173-3872-19c3.ngrok-free.app/uploadimage"));
    final headersb = {"Content-type": "multipart/form-data"};

    final headers = {"Content-type": "multipart/form-data","data":bbstr};
    final requestb =  http.MultipartRequest("POST", Uri.parse("https://cb92-2402-3a80-1929-6317-55b5-50d5-861e-f16a.ngrok-free.app//uploadbbox"));




//    final headers = ("Content-type": "multipart/form-data");

    request.files.add(http.MultipartFile('image',image!.readAsBytes().asStream(),image!.lengthSync(),
        filename: image!.path.split("/").last));

    // requestb.files.add(http.MultipartFile('file',BBfile!.readAsBytes().asStream(),BBfile!.lengthSync(),
    //     filename: BBfile!.path.split("/").last));

    request.headers.addAll(headers);
    response = await request.send();
    http.Response res = await http.Response.fromStream(response);
    final resJson = jsonDecode(res.body);
    message = resJson['message'];
    print(message);

   // NumberPage(responseData: resJson.toString());

    // requestb.headers.addAll(headersb);
    // final responseb = await requestb.send();
    // http.Response resb = await http.Response.fromStream(responseb);
    // final resJsonb = jsonDecode(resb.body);
    // message = resJsonb['message'];

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('image Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (image != null)
              Image.file(
                image!,
                width: 500,
                height: 600,
                fit: BoxFit.cover,
              ),
            // TextButton.icon(
            //     style: ButtonStyle(
            //       // backgroundColor: MaterialStateColor.all(Colors.black45),
            //     ),
            //     onPressed: uploadImage, icon: Icon(Icons.upload_file), label: Text("Upload")
            // ),
            ElevatedButton(

              onPressed: () {
                // handle button press
                uploadImage();
                Navigator.push(context,
                    MaterialPageRoute(builder:(context) =>  NumberPage(responseData: response.body)));
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white, // set the background color of the button
              ),
              child: Text('Count',style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Arial',
                color: Colors.black45,
              ),),
            ),
          ],
        ),
      ),

    );


  }
}