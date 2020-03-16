//Thomas Yamasaki
//Comp 499
//Test page for DB functions

import 'package:flutter/material.dart';
import 'package:guitarsheets/UI/Forms/songform.dart';

class TestPage extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,),
      body: Center(
        child: Text(
          "Error: No Songsterr tab URL stored",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24
          ),
        ),
      )
    );
  }
}