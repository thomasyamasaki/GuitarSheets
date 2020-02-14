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
  int mediaID;
  String mediaName;
  String mediaType;
  String mediaLocation;
  String mediaSize;

  Media({
    this.mediaID,
    this.mediaName,
    this.mediaType,
    this.mediaLocation,
    this.mediaSize
  });

  factory Media.fromMap(Map<String, dynamic> json) => new Media(
    mediaID: json["Media_ID"],
    mediaName: json["Media_Name"],
    mediaType: json["Media_Type"],
    mediaLocation: json["Media_Location"],
    mediaSize: json["Media_Size"],
  );

  Map<String, dynamic> toMap() => {
    "Media_ID": mediaID, 
    "Media_Name": mediaName,
    "Media_Type": mediaType,
    "Media_Location": mediaLocation,
    "Media_Size": mediaSize,
  };
}