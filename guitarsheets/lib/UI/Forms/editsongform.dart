import 'package:flutter/material.dart';
import 'package:guitarsheets/DB/Database.dart';
import 'package:guitarsheets/DB/SongModel.dart';

class EditSongForm extends StatefulWidget {
  final Song song;

  EditSongForm({Key key, @required this.song}) : super(key: key);

  @override 
  _EditSongState createState() => _EditSongState(song);
}

class _EditSongState extends State<EditSongForm> {
  final _formKey = GlobalKey<FormState>();
  Song _song;

  _EditSongState(Song song) {
    this._song = song;
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
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
                  InputDecoration(labelText: 'Song Title',),
                  initialValue: _song.songTitle,
                  onSaved: (val) => setState(() => _song.songTitle = val)),
                TextFormField(decoration:
                  InputDecoration(labelText: 'Song Artist'),
                  initialValue: _song.songArtist,
                  onSaved: (val) => setState(() => _song.songArtist = val)),
                TextFormField(decoration:
                  InputDecoration(labelText: 'Song Genre'),
                  initialValue: _song.songGenre,
                  onSaved: (val) => setState(() => _song.songGenre = val)),
                TextFormField(decoration:
                  InputDecoration(labelText: 'Song Length'),
                  initialValue: _song.songLength,
                  onSaved: (val) => setState(() => _song.songLength = val),),
                Text('Songsterr Search'),
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
                      DBprovider.db.updateSong(_song);
                      Navigator.pop(context);
                    },
                  ),
                ),

                Container(padding: const EdgeInsets.symmetric(
                  vertical: 16.0, horizontal: 16.0),
                  child: RaisedButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              ]
            ),
          )
        )
      )
    );
  }
}