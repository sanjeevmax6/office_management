import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:office_management/services/database.dart';
import 'package:office_management/widgets/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  DatabaseMethods databaseMethods = new DatabaseMethods();

  final prefs = SharedPreferences.getInstance();
  String UserEmail = null;

  File uploadFile;
  var finalUrl;


  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  uploadFiles() async {
    int timestamp = new DateTime.now().millisecondsSinceEpoch;
//    StorageReference storageReference = FirebaseStorage.instance.ref().child("UserEmail" + timestamp.toString() + ".jpg");

//    StorageUploadTask uploadTask = storageReference.put(uploadFile);

    StorageReference storageReference = FirebaseStorage.instance.ref().child("Post Images");
    StorageUploadTask uploadTask = storageReference.child(timestamp.toString() + ".jpg").putFile(uploadFile);


//    var downloadUrl = await (await uploadTask).ref.getDownloadURL();
//    var url = downloadUrl.toString();
    print(finalUrl);

    Map<String, dynamic> fileMap = {
      "image": finalUrl,
      "time": DateTime.now().millisecondsSinceEpoch,
      "email": UserEmail
    };
    databaseMethods.addFiles(fileMap);


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(

      ),
      floatingActionButton: FloatingActionButton(
        elevation: 5.0,
        child: new Icon(Icons.save_alt),
        backgroundColor: Colors.lightGreen,
        onPressed: () async {
          final prefs = await SharedPreferences.getInstance();
          UserEmail = prefs.getString("email") ?? 0;
          print(finalUrl);
        },
      ),
    );
  }
}
