//Thomas Yamasaki
//Comp 499
//Model file for Song Media table

import 'dart:convert';

SongMedia songmediaFromJson(String str) {
  final jsonData = json.decode(str);
  return SongMedia.fromMap(jsonData);
}

String songmediaToJson(SongMedia data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class SongMedia {
  int songID;
  int mediaID;

  SongMedia({
    this.songID,
    this.mediaID
  });

  factory SongMedia.fromMap(Map<String, dynamic> json) => new SongMedia(
    songID: json["Song_ID"],
    mediaID: json["Media_ID"],
  );

  Map<String, dynamic> toMap() => {
    "Song_ID": songID,
    "Media_ID": mediaID,
  };
}