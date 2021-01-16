import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context){
  return AppBar(
    centerTitle: true,
    title: Text("Office Management", style: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
    ),),
  );
}