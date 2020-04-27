import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guitarsheets/API/songsterr_parser.dart';
import 'package:guitarsheets/API/songsterr_result.dart';
import 'package:guitarsheets/UI/Views/webview.dart';
import 'package:guitarsheets/DB/SongModel.dart';

class SongsterrSearch extends StatefulWidget {
  final Song song;
  final TextEditingController titlecon;
  final TextEditingController artistcon;
  final TextEditingController scon;

  SongsterrSearch({Key key, @required this.song, this.titlecon, this.artistcon, this.scon}): super(key: key);

  @override 
  _SongsterrSearchState createState() => _SongsterrSearchState(song, titlecon, artistcon, scon);
}

class _SongsterrSearchState extends State<SongsterrSearch> {
  Song song;
  TextEditingController titlecon;
  TextEditingController artistcon;
  TextEditingController scon;

  _SongsterrSearchState(Song song, TextEditingController titlecon, TextEditingController artistcon, TextEditingController scon) {
    this.song = song;
    this.titlecon = titlecon;
    this.artistcon = artistcon;
    this.scon = scon;
  }

  /*void dispose() {
    titlecon.dispose();
    artistcon.dispose();
    scon.dispose();
    super.dispose();
  }*/

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,
        title: Text('Songsterr.com Tab Search', style: GoogleFonts.b612(),),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.teal[300], Color(0xfff88379)], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SearchBar<SongsterrResult>(
          searchBarStyle: SearchBarStyle(
            backgroundColor: Colors.grey[200]
          ),
          onSearch: getSongsterrResults,
          minimumChars: 4,
          debounceDuration: Duration(milliseconds: 500),
          onItemFound: (SongsterrResult result, int index) {
            return Container( 
              //color: Colors.white,
              /*decoration: BoxDecoration( 
                            boxShadow: [
                              BoxShadow(color: Colors.grey, blurRadius: 20)
                            ]
                          ),*/
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Card(
                      color: Colors.white,
                    child: ListTile( 
                      title: Text(result.stitle),
                      onTap: (){
                        setState(() {
                          //song.songsterrURL = result.surl;
                          scon.text = result.surl;
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
                    )),
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
              )
            );
          },
        ),
      ),
    );
  }
}