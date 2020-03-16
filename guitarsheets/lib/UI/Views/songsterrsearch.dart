import 'package:flutter/material.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:guitarsheets/API/songsterr_parser.dart';
import 'package:guitarsheets/API/songsterr_result.dart';
import 'package:guitarsheets/UI/Views/webview.dart';
import 'package:guitarsheets/DB/SongModel.dart';

class SongsterrSearch extends StatefulWidget {
  final Song song;

  SongsterrSearch({Key key, @required this.song}): super(key: key);

  @override 
  _SongsterrSearchState createState() => _SongsterrSearchState(song);
}

class _SongsterrSearchState extends State<SongsterrSearch> {
  Song song;

  _SongsterrSearchState(Song song) {
    this.song = song;
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SearchBar<SongsterrResult>(
          onSearch: getSongsterrResults,
          onItemFound: (SongsterrResult result, int index) {
            return Row(
              children: <Widget>[
                Expanded(
                  child: ListTile( 
                    title: Text(result.stitle),
                    onTap: (){
                      setState(() {
                        song.songsterrURL = result.surl;
                      });
                      Navigator.pop(context);
                    },
                  )
                  ),
                Column(
                  children: <Widget>[
                    IconButton(icon: Icon(Icons.visibility), 
                    onPressed: (){
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => WebViewPage(url: result.surl,))
                      );
                    },)
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}