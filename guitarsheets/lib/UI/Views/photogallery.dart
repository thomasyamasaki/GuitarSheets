import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'dart:io';

class PhotoGallery extends StatelessWidget {
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
}