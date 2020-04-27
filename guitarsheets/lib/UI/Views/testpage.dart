//Thomas Yamasaki
//Comp 499
//Test page for DB functions

import 'package:flutter/material.dart';
//import 'package:guitarsheets/UI/Forms/songform.dart';

class TestPage extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.teal[300], Color(0xfff88379)], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Center(
          child: Text(
            "Error: No Songsterr tab URL stored for this song entry",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24
            ),
          ),
        )
      )
    );
  }
}