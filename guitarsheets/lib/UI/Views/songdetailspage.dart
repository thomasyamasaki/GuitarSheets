import 'package:flutter/material.dart';
import 'package:guitarsheets/DB/Database.dart';
import 'package:guitarsheets/DB/SongModel.dart';
import 'package:guitarsheets/UI/Forms/editsongform.dart';
import 'package:guitarsheets/UI/Views/webview.dart';

class SongDetailsPage extends StatefulWidget {
  final Song song;
  SongDetailsPage({Key key, @required this.song}) : super(key: key);

  @override 
  _SongDetailState createState() => _SongDetailState(song);
}

class _SongDetailState extends State<SongDetailsPage> {
  Song song;

  _SongDetailState(Song song) {
    this.song = song;
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Song Details'),
      ),

      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: ListView(
          children: <Widget>[
            Text(song.songTitle + '\n',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
            ),
            Text('Title:',
              style: TextStyle(fontSize: 20),
            ),
            Text(song.songTitle + '\n',
              style: TextStyle(fontSize: 20),
            ),
            Text('Artist:',
              style: TextStyle(fontSize: 20),
            ),
            Text(song.songArtist + '\n',
              style: TextStyle(fontSize: 20),
            ),
            Text('Genre:',
              style: TextStyle(fontSize: 20),
            ),
            Text(song.songGenre + '\n',
              style: TextStyle(fontSize: 20),
            ),
            Text('Length:',
              style: TextStyle(fontSize: 20),
            ),
            Text(song.songLength + '\n',
              style: TextStyle(fontSize: 20),
            ),

            RaisedButton(
              child: Text('Songsterr tabs'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WebViewPage(url: 'https://songsterr.com'))
                );
              },
            ),

            RaisedButton( 
              child: Text('Edit Song'),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditSongForm(song: song,)
                  )
                );
              },
            ),
            
          ],
        ),
      ),
    );
  }
}