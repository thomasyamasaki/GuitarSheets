//Thomas Yamasaki
//Comp 499
//Dart file for bottom navigation bar implementation

import 'package:flutter/material.dart';

class AppView extends StatefulWidget {
  @override 
  State<StatefulWidget> createState() {
    return _AppViewState();
  }
}

class _AppViewState extends State<AppView> {

  int _currentIndex = 0;

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guitar Sheets')
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home')
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('List')
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search')
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Accounts')
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.vpn_key),
            title: Text('Test')
          )
          
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