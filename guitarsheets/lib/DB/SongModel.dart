//Thomas Yamasaki
//Comp 499
//Model file for Song table

import 'dart:convert';

Song taskFromJson(String str) {
  final jsonData = json.decode(str);
  return Song.fromMap(jsonData);
}

String songToJson(Song data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Song {
  int songID;
  String songTitle;
  String songArtist;
  String songGenre;
  String songLength;
  String songsterrURL;
  String gdDocID;

  Song({
    this.songID,
    this.songTitle,
    this.songArtist,
    this.songGenre,
    this.songLength,
    this.songsterrURL,
    this.gdDocID
  });

  factory Song.fromMap(Map<String, dynamic> json) => new Song(
    songID: json["Song_ID"],
    songTitle: json["Song_Title"],
    songArtist: json["Song_Artist"],
    songGenre: json["Song_Genre"],
    songLength: json["Song_Length"],
    songsterrURL: json["Songsterr_URL"],
    gdDocID: json["GD_Doc_ID"],
  );

  Map<String, dynamic> toMap() => {
    "Song_ID": songID,
    "Song_Title": songTitle,
    "Song_Artist": songArtist,
    "Song_Genre": songGenre,
    "Song_Length": songLength,
    "Songsterr_URL": songsterrURL,
    "GD_Doc_ID": gdDocID,
  };
}