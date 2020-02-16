//Thomas Yamasaki
//Comp 499
//Test page for DB functions

import 'package:flutter/material.dart';
import 'package:guitarsheets/UI/Forms/songform.dart';

class TestPage extends StatefulWidget {
  @override 
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override 
  Widget build(BuildContext build) {
    return SongForm();
  }
}
