// Thomas Yamasaki
// Comp 499
// Model file for Media table

import 'dart:convert';

Media taskFromJson(String str) {
  final jsonData = json.decode(str);
  return Media.fromMap(jsonData);
}

String taskToJson(Media data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Media {
  int id;
  String mediaName;
  String mediaType;
  String mediaLocation;
  String mediaSize;

  Media({
    this.id,
    this.mediaName,
    this.mediaType,
    this.mediaLocation,
    this.mediaSize
  });

  factory Media.fromMap(Map<String, dynamic> json) => new Media(
    id: json["id"],
    mediaName: json["media_name"],
    mediaType: json["media_type"],
    mediaLocation: json["media_location"],
    mediaSize: json["media_size"],
  );

  Map<String, dynamic> toMap() => {
    "id": id, 
    "media_name": mediaName,
    "media_type": mediaType,
    "media_location": mediaLocation,
    "media_size": mediaSize,
  };
}