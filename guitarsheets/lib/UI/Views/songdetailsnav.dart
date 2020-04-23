import 'package:flutter/material.dart';
import 'package:guitarsheets/UI/Views/songdetailspage.dart';
import 'package:guitarsheets/UI/Views/webview.dart';
import 'package:guitarsheets/UI/Views/photogallery.dart';
import 'package:guitarsheets/DB/Database.dart';
import 'package:guitarsheets/DB/SongModel.dart';
import 'package:guitarsheets/DB/SongMediaModel.dart';
import 'package:guitarsheets/DB/MediaModel.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DetailsNav extends StatefulWidget {
  final Song song;
  DetailsNav({Key key, @required this.song}) : super(key: key);
  @override 
  _DetailsNavState createState() => _DetailsNavState(song);
}

class _DetailsNavState extends State<DetailsNav> {
  Song song;
  List<File> photos = [];
  int _currentIndex = 0;

  _DetailsNavState(Song song) {
    this.song = song;
    getPhotosFromDB();
  }
  

  /*List<Widget> _detailPages = <Widget> [
    SongDetailsPage(), WebViewPage(url: null), PhotoGallery() 
  ];*/

  Widget getWidget(int index) {
    if (index == 0) {
      return SongDetailsPage(song: song,);
    }
    else if (index == 1) {
      return WebViewPage(url: song.songsterrURL);
    }
    else if (index == 2) {
      return PhotoGallery(pictures: photos,);
    }
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
      body: getWidget(_currentIndex),
      bottomNavigationBar: BottomNavigationBar( 
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.red[200],
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            title: Text('Song Details')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.web),
            title: Text('Songsterr')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo),
            title: Text('Photos')
          )
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}