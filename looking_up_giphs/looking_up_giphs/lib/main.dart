import 'package:flutter/cupertino.dart';
import 'package:looking_up_giphs/ui/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() {

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.transparent));
  runApp(MaterialApp(
    home: HomePage(),
        debugShowCheckedModeBanner: false,));
}


