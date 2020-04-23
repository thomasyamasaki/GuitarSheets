//Thomas Yamasaki
//Comp 499
//Dart file for bottom navigation bar implementation

import 'package:flutter/material.dart';
//import 'package:guitarsheets/UI/Views/accountpage.dart';
import 'package:guitarsheets/UI/Views/homepage.dart';
import 'package:guitarsheets/UI/Views/songlist.dart';
//import 'package:guitarsheets/UI/Views/songsearch.dart';
//import 'package:guitarsheets/UI/Views/testpage.dart';

class AppView extends StatefulWidget {
  @override 
  State<StatefulWidget> createState() {
    return _AppViewState();
  }
}

class _AppViewState extends State<AppView> {
  int _currentIndex = 0;

  List<Widget> _appviews = <Widget> [
    HomePage(), SongList()//, SongSearch()//, AccountPage(), TestPage()
  ];

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Guitar Sheets'),
        //backgroundColor: Colors.black,
      ),
      body: _appviews.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.red[200],//Colors.pink[200],
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('Tasks')
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            title: Text('Songs')
          ),

          /*BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search')
          ),*/

          /*BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Accounts')
          ),*/

          /*BottomNavigationBarItem(
            icon: Icon(Icons.vpn_key),
            title: Text('Test')
          )*/
          
        ]
      )
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}