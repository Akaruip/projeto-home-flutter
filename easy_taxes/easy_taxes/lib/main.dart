import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_taxes/ui/home_page.dart';

void main() {
   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
       statusBarBrightness: Brightness.light,
       statusBarColor: Colors.transparent
       ));
  runApp(MaterialApp(
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}
