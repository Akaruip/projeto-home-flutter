//import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text(
          "Easy Taxes",
          style: TextStyle(color: Colors.amber, fontSize: 20.0),
        ),
      ),
      bottomSheet: BottomAppBar(
          
          child: Container(color: Colors.red, width: 350.0, height: 50.0, alignment: Alignment(0,0),),),
          
    );
  }
}
