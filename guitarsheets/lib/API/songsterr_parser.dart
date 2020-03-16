import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:guitarsheets/API/songsterr_result.dart';

Future <List<SongsterrResult>> getSongsterrResults(String searchParameters) async {
  String url = "http://www.songsterr.com/a/ra/songs.json?pattern=" + searchParameters;
  final songsterrResponse = await http.get(url);
  //print(songsterrResponse.body);

  List responseJson = json.decode(songsterrResponse.body.toString());
  List<SongsterrResult> results = createResultList(responseJson);
  return results;
}

List<SongsterrResult> createResultList(List data) {
  List<SongsterrResult> results = new List();

  for (int i = 0; i < data.length; i++) {
    SongsterrResult result = new SongsterrResult(
      sid: data[i]["id"],
      stitle: data[i]["title"],
      sartist: data[i]["artist"]["name"],
      surl: 'http://www.songsterr.com/a/wa/song?id=' + data[i]["id"].toString()
    );
    results.add(result);
  }
  return results;
}
