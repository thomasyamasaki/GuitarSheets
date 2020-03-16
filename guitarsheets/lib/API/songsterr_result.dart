//import 'dart:convert';

/*SongsterrResult resultFromJson(String str) {
  final jsonData = json.decode(str);
  return SongsterrResult.fromMap(jsonData);
}

String resultToJson(SongsterrResult data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}*/

class SongsterrResult {
  int sid;
  String stitle;
  String sartist;
  String surl;

  SongsterrResult({
    this.sid,
    this.stitle,
    this.sartist,
    this.surl
  });

  /*factory SongsterrResult.fromMap(Map<String, dynamic> json) => new SongsterrResult(
    sid: json["id"],
    stitle: json["title"],
    sartist: json["artist"]["name"]
  );

  Map<String, dynamic> toMap() => {
    "id": sid,
    "title": stitle,
    "artist": sartist
  };*/
  
}