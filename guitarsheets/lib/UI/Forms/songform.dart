//Thomas Yamasaki
//Comp 499
//Form for adding a song entry to the Song list

import 'package:flutter/material.dart';
import 'package:guitarsheets/DB/Database.dart';
import 'package:guitarsheets/DB/SongModel.dart';
import 'package:guitarsheets/UI/Views/songsterrsearch.dart';

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
      appBar: AppBar(backgroundColor: Colors.black,),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Builder(
          builder: (context) => Form(
            key: _formKey,
            child: ListView(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              //padding: const EdgeInsets.symmetric(vertical: 16.0),
              children: [
                Text('Song Form'),
                TextFormField(decoration:
                  InputDecoration(labelText: 'Song Title'),
                  onSaved: (val) => setState(() => _song.songTitle = val)),
                TextFormField(decoration:
                  InputDecoration(labelText: 'Song Artist'),
                  onSaved: (val) => setState(() => _song.songArtist = val)),
                TextFormField(decoration:
                  InputDecoration(labelText: 'Song Genre'),
                  onSaved: (val) => setState(() => _song.songGenre = val)),
                TextFormField(decoration:
                  InputDecoration(labelText: 'Song Length'),
                  onSaved: (val) => setState(() => _song.songLength = val),),

                Container(padding: const EdgeInsets.symmetric(
                  vertical: 16.0, horizontal: 16.0), 
                  child: Row(
                    children: <Widget>[
                      Expanded( 
                        child: RaisedButton(
                          child: Text('Songsterr Tabs Search'),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SongsterrSearch(song: _song,)));
                          }
                        ),
                      ),
                      Column(children: <Widget>[
                        Icon(Icons.check_circle_outline)
                      ],)
                    ],
                  ),
                ),
                Text('Media'),
                Text('Photo Sheets'),
                Text('Audio Recordings'),

                Container(padding: const EdgeInsets.symmetric(  
                  vertical: 16.0, horizontal: 16.0),
                  child: RaisedButton(
                    child: Text('Save'),
                    onPressed: () {
                      final form = _formKey.currentState;
                      form.save();
                      DBprovider.db.insertSong(_song);
                      Navigator.pop(context);
                    },
                  ),
                ),

                /*Container(padding: const EdgeInsets.symmetric(
                  vertical: 16.0, horizontal: 16.0),
                  child: RaisedButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )*/
              ]
            ),
          )
        )
      )
    );
  }
}