import 'package:flutter/material.dart';
import 'package:guitarsheets/DB/Database.dart';
import 'package:guitarsheets/DB/SongModel.dart';
import 'package:guitarsheets/DB/MediaModel.dart';
import 'package:guitarsheets/DB/SongMediaModel.dart';
import 'package:guitarsheets/UI/Forms/songform.dart';
import 'package:guitarsheets/UI/Views/songdetailspage.dart';

class SongList extends StatefulWidget {
  @override 
  _SongListState createState() => _SongListState();
}

class _SongListState extends State<SongList> {

  @override
  Widget build(BuildContext build) {
    return Scaffold (
      floatingActionButton: 
        FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SongForm()));
          },
        ),
      body: FutureBuilder( 
        future: DBprovider.db.getAllSongs(),
        builder: (BuildContext context, AsyncSnapshot<List<Song>> songList) {
          if (songList.hasData) {
            return new Column(
              children: <Widget>[
                Text('Song List',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                
                new Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    itemCount: songList.data.length,
                    itemBuilder: (BuildContext context, int index){
                      Song song = songList.data[index];
                      return new Card(
                        child: ListTile( 
                          title: Text(song.songTitle),
                          onTap: () {
                            Navigator.push(context, 
                              MaterialPageRoute( 
                                builder: (context) => SongDetailsPage(song: songList.data[index],)
                              )
                            );
                          },
                        ),
                      );
                    },
                  )
                )
              ],
            );
          }
          else {
            return Center(child: CircularProgressIndicator(),);
          }
        },
      )
    );
  }
}