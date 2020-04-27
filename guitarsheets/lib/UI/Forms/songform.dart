//Thomas Yamasaki
//Comp 499
//Form for adding a song entry to the Song list

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guitarsheets/DB/Database.dart';
import 'package:guitarsheets/DB/SongModel.dart';
import 'package:guitarsheets/DB/MediaModel.dart';
//import 'package:guitarsheets/UI/TestViews/testphotoview.dart';
import 'package:guitarsheets/UI/Views/songsterrsearch.dart';
//import 'package:guitarsheets/UI/Views/photo_select.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class SongForm extends StatefulWidget {
  @override 
  _SongFormState createState() => _SongFormState();
}

class _SongFormState extends State<SongForm> {
  //for song portion
  final _formKey = GlobalKey<FormState>();
  final _song = Song();
  final _titlecontroller = TextEditingController();
  final _artistcontroller = TextEditingController();
  final _songsterrcontroller = TextEditingController();
  final _genrecontroller = TextEditingController();
  final _lengthcontroller = TextEditingController();

  //for media portion
  List<Media> medialist = [];
  //Media photo = Media();
  int currentMediaID;
  String currentMediaName;

  _SongFormState() {
    getCurrentSongID();
    //print(this._song.songID);
    getCurrentMediaID();
  }

  void dispose() {
    _titlecontroller.dispose();
    _artistcontroller.dispose();
    _songsterrcontroller.dispose();
    _genrecontroller.dispose();
    _lengthcontroller.dispose();
    super.dispose();
  }

  getCurrentMediaID() async {
    int currID = await DBprovider.db.getMediaID();
    currentMediaID = currID;
  }

  getCurrentSongID() async {
    int currID = await DBprovider.db.getSongID();
    this._song.songID = currID;
    //print(_song.songID);
  }

  selectFromCameraRoll() async {
    var img = await ImagePicker.pickImage(source: ImageSource.gallery);
    Directory appDocDir = await getApplicationDocumentsDirectory();
    currentMediaName = _song.songID.toString() + "_" + currentMediaID.toString() + ".jpg";
    String newpath = appDocDir.uri.resolve(currentMediaName).path;
    File pic = await img.copy(newpath);

    Media photo = Media();
    photo.mediaID = currentMediaID;
    photo.mediaName = currentMediaName;
    photo.mediaType = "PHOTO";
    //photo.mediaLocation = newpath;
    currentMediaID += 1;
    medialist.add(photo);
    setState(() {});
  }

  takePicWithCamera() async {
    var img = await ImagePicker.pickImage(source: ImageSource.camera);
    Directory appDocDir = await getApplicationDocumentsDirectory();
    currentMediaName = _song.songID.toString() + "_" + currentMediaID.toString() + ".jpg";
    String newpath = appDocDir.uri.resolve(currentMediaName).path;
    File pic = await img.copy(newpath);

    Media photo = Media();
    photo.mediaID = currentMediaID;
    photo.mediaName = currentMediaName;
    photo.mediaType = "PHOTO";
    currentMediaID += 1;
    medialist.add(photo);
    setState(() {});
  }

  deletePhotoFromPhone(Media photo) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String photoPath = join(appDocDir.path, photo.mediaName);
    File file = new File(photoPath);
    file.delete();
  }

  Widget displayMediaList() {
    return medialist.isNotEmpty
      ? ListView.builder(
            shrinkWrap: true,
            itemCount: medialist.length,
            itemBuilder: (BuildContext context, int index) {
              return Card( 
                child: ListTile( 
                  title: Text(medialist[index].mediaName),
                  leading: IconButton( 
                    icon: Icon(Icons.clear),
                    onPressed: (){
                      deletePhotoFromPhone(medialist[index]);
                      setState(() {
                        medialist.removeAt(index);
                      });
                    },
                  ),
                ),
              );
            }
          )
      : Text("No Images added");          
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('New Song', style: GoogleFonts.b612(),),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.teal[300], Color(0xfff88379)], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Builder(
          builder: (context) => Form(
            key: _formKey,
            child: ListView(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              //padding: const EdgeInsets.symmetric(vertical: 16.0),
              children: [
                Text('Basic Details', textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
                ),
                TextFormField(decoration:
                  InputDecoration(labelText: 'Song Title',
                    suffixIcon: IconButton(icon: Icon(Icons.clear)
                    , onPressed: () => _titlecontroller.clear())
                  ),
                  controller: _titlecontroller,
                  onSaved: (val) => setState(() => _song.songTitle = val)),
                TextFormField(decoration:
                  InputDecoration(labelText: 'Song Artist',
                    suffixIcon: IconButton(icon: Icon(Icons.clear), 
                    onPressed: () => _artistcontroller.clear()
                    )
                  ),
                  controller: _artistcontroller,
                  onSaved: (val) => setState(() => _song.songArtist = val)),
                TextFormField(decoration:
                  InputDecoration(labelText: 'Song Genre',
                    suffixIcon: IconButton(icon: Icon(Icons.clear), 
                    onPressed: () => _genrecontroller.clear()
                    )
                  ),
                  controller: _genrecontroller,
                  onSaved: (val) => setState(() => _song.songGenre = val)),
                TextFormField(decoration:
                  InputDecoration(labelText: 'Song Length',
                    suffixIcon: IconButton(icon: Icon(Icons.clear)
                    , onPressed: () => _lengthcontroller.clear())
                  ),
                  controller: _lengthcontroller,
                  onSaved: (val) => setState(() => _song.songLength = val),),

                Text("\n"),
                Text('Songsterr tab search', textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
                ),

                Container(
                  //padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0), 
                  child: Row(
                    children: <Widget>[
                      /*Expanded( 
                        child: RaisedButton(
                          child: Text('Songsterr Tabs Search'),
                          onPressed: (){
                            Navigator.push(
                              context, MaterialPageRoute(
                                builder: (context) => SongsterrSearch(song: _song,
                                  titlecon: _titlecontroller, artistcon: _artistcontroller,)));
                          }
                        ),
                      ),*/
                      Expanded( 
                        child: TextFormField( 
                          decoration: InputDecoration(labelText: 'Songsterr URL'),
                          keyboardType: TextInputType.multiline,
                          minLines: 2,
                          maxLines: null,
                          controller: _songsterrcontroller,
                          onSaved: (val) => setState(() => _song.songsterrURL = val),
                        ),
                      ),

                      IconButton(icon: Icon(Icons.close), 
                        onPressed: () {
                          setState(() {
                            _songsterrcontroller.clear();
                          });
                        }
                      ),
                      
                      Column(children: <Widget>[
                        //Icon(Icons.check_circle_outline)
                        IconButton(icon: Icon(Icons.search), 
                          onPressed: () {
                            Navigator.push(
                              context, MaterialPageRoute(
                                builder: (context) => SongsterrSearch(song: _song,
                                  titlecon: _titlecontroller, artistcon: _artistcontroller, scon: _songsterrcontroller,)));
                          }
                        )
                      ],)
                    ],
                  ),
                ),

                Text("\n"),
                
                Text('Import Photo Sheets\n', textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
                ),

                Text('Source:\n',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),

                Center(
                  child: Row(children: <Widget>[
                    Expanded( 
                      child: IconButton(icon: Icon(Icons.photo), onPressed: selectFromCameraRoll),
                    ),
                    Expanded( 
                      child: IconButton(icon: Icon(Icons.camera), onPressed: takePicWithCamera),
                    )
                    
                    
                  ],),
                ),

                /*Container(padding: const EdgeInsets.symmetric(
                  vertical: 16.0, horizontal: 16.0),
                  child: RaisedButton( 
                    child: Text('Import photo from gallery'),
                    onPressed: selectFromCameraRoll,
                  ),

                ),

                Container(padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    child: RaisedButton( 
                      child: Text('Take photo with camera'),
                      onPressed: takePicWithCamera,
                    ),
                ),*/

                Text('\n\nPhoto List:\n',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),

                Column(//padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    children: <Widget>[
                        displayMediaList()
                    ], 
                ),

                /*Container(padding: const EdgeInsets.symmetric(  
                  vertical: 16.0, horizontal: 16.0),
                  child: 
                    RaisedButton(
                      child: Text('Photo Sheets'),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PhotoSelect(song: _song, medialist: medialist,)
                          )
                        );
                      },
                    ),

                ),*/

                Text('\n\n'),

                Container(padding: const EdgeInsets.symmetric(  
                  vertical: 16.0, horizontal: 16.0),
                  child: RaisedButton(
                    color: Colors.white,
                    child: Text('Save'),
                    onPressed: () {
                      final form = _formKey.currentState;
                      form.save();

                      //insert song into DB
                      DBprovider.db.insertSong(_song);
                      
                      if (medialist.length > 0) {
                        //insert Media entries into DB if there are photos
                        for (int i = 0; i < medialist.length; i++) {
                          DBprovider.db.insertMedia(medialist[i]);
                        }

                        //create intersections for Song Media table
                        for (int j = 0; j < medialist.length; j++) {
                          DBprovider.db.insertIntersection(_song.songID, medialist[j].mediaID);
                        }
                      }
                      
                      Navigator.pop(context);
                    },
                  ),
                ),

                /*Container(padding: const EdgeInsets.symmetric(
                  vertical: 16.0, horizontal: 16.0),
                  child: RaisedButton(
                    child: Text('Press to test stuff'),
                    onPressed: () {
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => TestPhotoView()));
                      for (int i = 0; i < medialist.length; i++) {
                        print(medialist[i].mediaID);
                      }
                    },
                  ),
                ),*/
              ]
            ),
          )
        )
      )
    );
  }
}