import 'package:flutter/material.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:guitarsheets/API/songsterr_parser.dart';
import 'package:guitarsheets/API/songsterr_result.dart';
import 'package:guitarsheets/UI/Views/webview.dart';
import 'package:guitarsheets/DB/SongModel.dart';

class SongsterrSearch extends StatefulWidget {
  final Song song;
  final TextEditingController titlecon;
  final TextEditingController artistcon;

  SongsterrSearch({Key key, @required this.song, this.titlecon, this.artistcon}): super(key: key);

  @override 
  _SongsterrSearchState createState() => _SongsterrSearchState(song, titlecon, artistcon);
}

class _SongsterrSearchState extends State<SongsterrSearch> {
  Song song;
  TextEditingController titlecon;
  TextEditingController artistcon;

  _SongsterrSearchState(Song song, TextEditingController titlecon, TextEditingController artistcon) {
    this.song = song;
    this.titlecon = titlecon;
    this.artistcon = artistcon;
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SearchBar<SongsterrResult>(
          onSearch: getSongsterrResults,
          minimumChars: 4,
          debounceDuration: Duration(milliseconds: 500),
          onItemFound: (SongsterrResult result, int index) {
            return Row(
              children: <Widget>[
                Expanded(
                  child: ListTile( 
                    title: Text(result.stitle),
                    onTap: (){
                      setState(() {
                        song.songsterrURL = result.surl;
                        if (titlecon.text.isEmpty == true) {
                          titlecon.text = result.stitle;
                          titlecon.selection= TextSelection.fromPosition(TextPosition(offset: titlecon.text.length));
                        }
                        if (artistcon.text.isEmpty == true) {
                          artistcon.text = result.sartist;
                          artistcon.selection = TextSelection.fromPosition(TextPosition(offset: artistcon.text.length));
                        }

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