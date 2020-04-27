import 'package:flutter/material.dart';
//import 'package:photo_view/photo_view.dart';
//import 'package:photo_view/photo_view_gallery.dart';
import 'dart:io';
import 'dart:async';

import 'package:google_fonts/google_fonts.dart';

/*class PhotoGallery extends StatelessWidget {
  final List<File> pictures;

  PhotoGallery({Key key, @required this.pictures}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar( 
        title: Text('Photo Gallery'),
      ),
      body: Container( 
        child: PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          itemCount: pictures.length, 
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: FileImage(pictures[index]),
              initialScale: PhotoViewComputedScale.contained * 0.8,
            );
          },
          loadingBuilder: (context, event) => Center(
            child: Container( 
              width: 20.0,
              height: 20.0,
              child: CircularProgressIndicator( 
                value: event == null
                  ? 0
                  : event.cumulativeBytesLoaded/event.expectedTotalBytes
              ),
            ),
          ),
        ),
      )
    );
  }
}*/

class PhotoGallery extends StatefulWidget {
  final List<File> pictures;

  PhotoGallery({Key key, @required this.pictures}) : super(key: key);

  @override 
  _PhotoGalleryState createState() => _PhotoGalleryState(pictures);
}

class _PhotoGalleryState extends State<PhotoGallery> with TickerProviderStateMixin {

  List<File> pictures;

  ScrollController _scrollController = ScrollController();
  bool scroll = false;
  int speedFactor = 20;
  Icon scrollButton;
  int iconIndex = 0;

  List<Icon> icons = [
    Icon(Icons.play_arrow),
    Icon(Icons.stop)
  ];

  _toggleIcon() {
    if (iconIndex == 0) {
      iconIndex = 1;
    }
    else {
      iconIndex = 0;
    }
  }

  _PhotoGalleryState(List<File> pictures) {
    this.pictures = pictures;
  }

  _scroll() {
    double max = _scrollController.position.maxScrollExtent;
    double distancedifference = max - _scrollController.offset;
    double duration = distancedifference/speedFactor;

    _scrollController.animateTo(_scrollController.position.maxScrollExtent, 
      duration: Duration(seconds: duration.toInt()), curve: Curves.linear);
  }

  _toggleScroll() {
    setState(() {
      scroll = !scroll;
    });

    if (scroll) {
      _scroll();
    }
    else {
      _scrollController.animateTo(_scrollController.offset, duration: Duration(seconds: 1), curve: Curves.linear);
    }
  }

  Widget displayPhotos() {

    return pictures.isNotEmpty
      ? ListView.builder(
          shrinkWrap: true,
          itemCount: pictures.length,
          controller: _scrollController,
          itemBuilder: (BuildContext context, int index) {
            return Container( 
              child: Image.file(pictures[index]),
            );
          },
        )
       
      
      
      : Container ( 
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.teal[300], Color(0xfff88379)], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Center( 
          child: Text(
            "Error: No photos stored for this song entry",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24
            ),
          ),
        ),
      );
  }

  @override 
  Widget build(BuildContext build) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Gallery', style: GoogleFonts.b612(),),
      ),
      body: NotificationListener( 
        onNotification: (notification) {
          if (notification is ScrollEndNotification && scroll) {
            Timer(Duration(seconds: 1), () {
              _scroll();
            });
          }
        },
        child: displayPhotos()
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton( 
        child: icons[iconIndex],
        onPressed: () {
          _toggleScroll();
          _toggleIcon();
        },
      ),
    );
  }
}