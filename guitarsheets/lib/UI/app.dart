//Thomas Yamasaki
//Comp 499

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guitarsheets/UI/navigator.dart';
//import 'testpage.dart';

class App extends StatelessWidget {
  @override 
  Widget build(BuildContext build ) {
    return MaterialApp(
      theme: ThemeData( 
        brightness: Brightness.light,
        primaryColor: Colors.black,
        accentColor: Colors.pink[500],//Colors.teal[600],
        backgroundColor: Colors.red,
        textTheme: GoogleFonts.b612TextTheme()
      ),
      home: AppView()
    );
  }
}