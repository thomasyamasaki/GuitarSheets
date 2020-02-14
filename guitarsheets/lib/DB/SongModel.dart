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
    this.songGenre,
    this.songLength,
    this.songsterrURL,
    this.gdDocID
  });

  factory Song.fromMap(Map<String, dynamic> json) => new Song(
    songID: json["song_id"],
    songTitle: json["song_title"],
    songGenre: json["song_genre"],
    songLength: json["song_length"],
    songsterrURL: json["songsterr_url"],
    gdDocID: json["gd_doc_id"],
  );

  Map<String, dynamic> toMap() => {
    "song_id": songID,
    "song_title": songTitle,
    "song_genre": songGenre,
    "song_length": songLength,
    "songsterr_url": songsterrURL,
    "gd_doc_id": gdDocID,
  };
}