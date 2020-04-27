import 'package:flutter/material.dart';
import 'package:guitarsheets/DB/Database.dart';
import 'package:guitarsheets/DB/SongModel.dart';
//import 'package:guitarsheets/DB/MediaModel.dart';
//import 'package:guitarsheets/DB/SongMediaModel.dart';
import 'package:guitarsheets/UI/Forms/songform.dart';
import 'package:guitarsheets/UI/Views/songdetailsnav.dart';
//import 'package:guitarsheets/UI/Views/songdetailspage.dart';

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
          //backgroundColor: Colors.teal[400],
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SongForm()));
          },
        ),
      body: Container( 
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.teal[300], Color(0xfff88379)], begin: Alignment.topCenter, end: Alignment.bottomCenter)
        ),
        child: FutureBuilder( 
          future: DBprovider.db.getAllSongs(),
          builder: (BuildContext context, AsyncSnapshot<List<Song>> songList) {
            if (songList.hasData) {
              return new Column(
                children: <Widget>[
                  Text(''),
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
                        return Container(
                          decoration: BoxDecoration( 
                            boxShadow: [
                              BoxShadow(color: Colors.grey, blurRadius: 20)
                            ]
                          ),
                          child: Card(
                            color: Colors.white,
                            child: ListTile( 
                              title: Text(song.songTitle,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                              onTap: () {
                                Navigator.push(context, 
                                  MaterialPageRoute( 
                                    builder: (context) => DetailsNav(song: songList.data[index],)//SongDetailsPage(song: songList.data[index],)
                                  )
                                );
                              },
                            ),
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
      )
      
    );
  }
}