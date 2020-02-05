// Thomas Yamasaki
// Comp 499
// Class file for SQLite Database functionality

import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

//import models
import 'SongModel.dart';
import 'TaskModel.dart';
import 'MediaModel.dart';
//import 'SongMediaModel.dart';

class DBprovider {
  DBprovider._();
  static final DBprovider db = DBprovider._();

  static Database _database;

  Future<Database> get database async {
    //if the database exists, return it
    if (_database != null)
    return _database;

    //Otherwise, create the database
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory docDir = await getApplicationDocumentsDirectory();
    String dbPath = join(docDir.path, "GSDB.db");
    
    return await openDatabase(dbPath, version: 1, onOpen: (db) {},
    onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Task ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
        "task_title TEXT,"
        "song TEXT,"
        "task_description TEXT"
        ")");

      await db.execute("CREATE TABLE Song ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
        "song_title TEXT,"
        "song_artist TEXT,"
        "song_genre TEXT,"
        "song_length TEXT,"
        "songsterr_url TEXT,"
        "gd_doc_id TEXT"
        ")");

      await db.execute("CREATE TABLE Media ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
        "media_name TEXT,"
        "media_type TEXT,"
        "media_location TEXT,"
        "media_size TEXT"
        ")");

      await db.execute('PRAGMA foreign_keys = ON');

      await db.execute("CREATE TABLE Song_Media ("
        "song_id INTEGER,"
        "media_id INTEGER,"
        "FOREIGN KEY(song_id) REFERENCES Song(id),"
        "FOREIGN KEY(media_id) REFERENCES Media(id)"
        ")");
    });
  }

  //Create operations:

  insertSong(Song song) {

  }

  insertTask(Task task) {

  }

  insertMedia(Media media) {

  }

  //Read operations:

  getSong(int id) {

  }

  getAllSongs() async {

  }

  //Update operations:

  updateSong(Song newSong) {

  }

  //Delete operations:

  deleteSong(int id) async {
    final db = await database;
    return db.delete("Song", where: "id = ?", whereArgs: [id]);
  }

  deleteAllSongs() async {
    final db = await database;
    db.rawDelete("Delete * from Song");
  }

  deleteTask(int id) async {
    final db = await database;
    return db.delete("Task", where: "id = ?", whereArgs: [id]);
  }

  deleteAllTasks() async {
    final db = await database;
    db.rawDelete("Delete * from Task");
  }
  
  deleteMedia(int id) async {
    final db = await database;
    return db.delete("Media", where: "id = ?", whereArgs: [id]);
  }

  deleteAllMedia() async {
    final db = await database;
    db.rawDelete("Delete * from Media");
  }
}