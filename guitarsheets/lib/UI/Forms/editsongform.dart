import 'package:flutter/material.dart';
import 'package:guitarsheets/DB/Database.dart';
import 'package:guitarsheets/DB/SongModel.dart';
import 'package:guitarsheets/UI/Views/songsterrsearch.dart';

class EditSongForm extends StatefulWidget {
  final Song song;

  EditSongForm({Key key, @required this.song}) : super(key: key);

  @override 
  _EditSongState createState() => _EditSongState(song);
}

class _EditSongState extends State<EditSongForm> {
  final _formKey = GlobalKey<FormState>();
  Song _song;
  final _titlecontroller = TextEditingController();
  final _artistcontroller = TextEditingController();

  _EditSongState(Song song) {
    this._song = song;
    _titlecontroller.text = _song.songTitle;
    _artistcontroller.text = _song.songArtist;
  }

  void dispose() {
    _titlecontroller.dispose();
    _artistcontroller.dispose();
    super.dispose();
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: Text('Edit Song'),
        backgroundColor: Colors.black,
      ),
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
                  //initialValue: _song.songTitle,
                  controller: _titlecontroller,
                  onSaved: (val) => setState(() => _song.songTitle = val)),
                TextFormField(decoration:
                  InputDecoration(labelText: 'Song Artist'),
                  //initialValue: _song.songArtist,
                  controller: _artistcontroller,
                  onSaved: (val) => setState(() => _song.songArtist = val)),
                TextFormField(decoration:
                  InputDecoration(labelText: 'Song Genre'),
                  initialValue: _song.songGenre,
                  onSaved: (val) => setState(() => _song.songGenre = val)),
                TextFormField(decoration:
                  InputDecoration(labelText: 'Song Length'),
                  initialValue: _song.songLength,
                  onSaved: (val) => setState(() => _song.songLength = val),),

                Container( 
                  padding: EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded( 
                        child: RaisedButton(
                          child: Text('Songsterr Tabs Search'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SongsterrSearch( 
                                  song: _song,
                                  titlecon: _titlecontroller,
                                  artistcon: _artistcontroller,
                                )
                              )
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),

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