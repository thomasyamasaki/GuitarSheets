//Thomas Yamasaki
//Comp 499
//Form for adding a song entry to the Song list

import 'package:flutter/material.dart';
//import 'package:guitarsheets/DB/Database.dart';
import 'package:guitarsheets/DB/SongModel.dart';

class SongForm extends StatefulWidget {
  @override 
  _SongFormState createState() => _SongFormState();
}

class _SongFormState extends State<SongForm> {
  final _formKey = GlobalKey<FormState>();
  final _song = Song();

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Builder(
          builder: (context) => Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Song Form'),
                TextFormField(decoration:
                  InputDecoration(labelText: 'Song Title'),
                  onSaved: (val) => setState(() => _song.songTitle = val))
              ]
            ),
          )
        )
      )
    );
  }
}