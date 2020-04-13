import 'package:flutter/material.dart';
import 'package:guitarsheets/DB/Database.dart';
import 'package:guitarsheets/DB/MediaModel.dart';
//import 'package:guitarsheets/API/songsterr_parser.dart';
//import 'package:guitarsheets/DB/Database.dart';
import 'package:guitarsheets/DB/SongModel.dart';
import 'package:guitarsheets/DB/SongMediaModel.dart';
import 'package:guitarsheets/UI/Forms/editsongform.dart';
import 'package:guitarsheets/UI/Views/photogallery.dart';
import 'package:guitarsheets/UI/Views/testpage.dart';
import 'package:guitarsheets/UI/Views/webview.dart';
import 'dart:io';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';

class SongDetailsPage extends StatefulWidget {
  final Song song;
  SongDetailsPage({Key key, @required this.song}) : super(key: key);

  @override 
  _SongDetailState createState() => _SongDetailState(song);
}

class _SongDetailState extends State<SongDetailsPage> {
  Song song;
  List<File> photos = [];

  _SongDetailState(Song song) {
    this.song = song;
    getPhotosFromDB();
  }

  getPhotosFromDB() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    List<SongMedia> picIDs = await DBprovider.db.getPhotoIDs(song.songID);
    for (int i = 0; i < picIDs.length; i++) {
      Media tempPic = await DBprovider.db.getMedia(picIDs[i].mediaID);
      String dir = join(appDocDir.path, tempPic.mediaName);
      File pic = new File(dir);
      photos.add(pic);
      //print(dir);
    }
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
                if (song.songsterrURL == null) {
                  Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => TestPage())
                  );
                }
                else {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WebViewPage(url: song.songsterrURL))
                  );
                }
              },
            ),

            RaisedButton( 
              child: Text('View Photos'),
              onPressed: () {
                Navigator.push(context, 
                  MaterialPageRoute( 
                    builder: (context) => PhotoGallery(pictures: photos,)
                  )
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

            /*Row(
              children: <Widget>[
                Expanded(
                  child:
                    FlatButton(child: Text('Heres Johnny'), onPressed: (){}, )
                  
                ),
                Column(
                  children: <Widget>[
                    IconButton(icon: Icon(Icons.visibility), onPressed: (){},)
                  ],
                )
              ],
            ),*/
            
          ],
        ),
      ),
    );
  }
}