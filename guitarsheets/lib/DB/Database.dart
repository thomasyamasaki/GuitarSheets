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
import 'SongMediaModel.dart';

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
    String dbPath = join(docDir.path, "GuitarSheetsDB.db");
    
    return await openDatabase(dbPath, version: 2, onOpen: (db) {},
    onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Task ("
        "Task_ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
        "Task_Title TEXT,"
        "Song TEXT,"
        "Task_Description TEXT"
        ")");

      await db.execute("CREATE TABLE Song ("
        "Song_ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
        "Song_Title TEXT,"
        "Song_Artist TEXT,"
        "Song_Genre TEXT,"
        "Song_Length TEXT,"
        "Songsterr_URL TEXT,"
        "GD_Doc_ID TEXT"
        ")");

      await db.execute("CREATE TABLE Media ("
        "Media_ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
        "Media_Name TEXT,"
        "Media_Type TEXT,"
        "Media_Location TEXT,"
        "Media_Size TEXT"
        ")");

      await db.execute('PRAGMA foreign_keys = ON');

      await db.execute("CREATE TABLE Song_Media ("
        "Song_ID INTEGER,"
        "Media_ID INTEGER,"
        "FOREIGN KEY(Song_ID) REFERENCES Song(Song_ID),"
        "FOREIGN KEY(Media_ID) REFERENCES Media(Media_ID)"
        ")");
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        if (oldVersion < newVersion) {
          await db.execute("DROP TABLE IF EXISTS Task");
          await db.execute("DROP TABLE IF EXISTS Song");
          await db.execute("DROP TABLE IF EXISTS Media");
          await db.execute("DROP TABLE IF EXISTS Song_Media");
        }
      }
    );

  }

  //Create operations:

  insertSong(Song song) async {
    final db = await database;
    var res = await db.insert("Song", song.toMap());
    return res;
  }

  insertTask(Task task) async {
    final db = await database;
    var res = await db.insert("Task", task.toMap());
    return res;
  }

  insertMedia(Media media) async {
    final db = await database;
    var res = await db.insert("Media", media.toMap());
    return res;
  }

  //Song media table foreign key intersection
  createLink(SongMedia intersection) async {
    final db = await database;
    var res = await db.insert("Song_Media", intersection.toMap());
    return res;
  }

  //Read operations:

  getSong(int songID) async {
    final db = await database;
    var res = await db.query("Song", where: "Song_ID = ?", whereArgs: [songID]);
    return res.isNotEmpty ? Song.fromMap(res.first) : Null;
  }

  getAllSongs() async {
    final db = await database;
    var res = await db.query("Song");
    List<Song> list = res.isNotEmpty ? res.map((s) => Song.fromMap(s)).toList() : [];
    return list;
  }

  //Update operations:

  updateSong(Song newSong) async {
    final db = await database;
    var res = await db.update("Song", newSong.toMap(), where: "Song_ID = ?", whereArgs: [newSong.songID]);
    return res;
  }

  //Delete operations:

  deleteSong(int songID) async {
    final db = await database;
    return db.delete("Song", where: "Song_ID = ?", whereArgs: [songID]);
  }

  deleteAllSongs() async {
    final db = await database;
    db.rawDelete("Delete from Song");
  }

  deleteTask(int taskID) async {
    final db = await database;
    return db.delete("Task", where: "Task_ID = ?", whereArgs: [taskID]);
  }

  deleteAllTasks() async {
    final db = await database;
    db.rawDelete("Delete from Task");
  }
  
  deleteMedia(int mediaID) async {
    final db = await database;
    return db.delete("Media", where: "Media_ID = ?", whereArgs: [mediaID]);
  }

  deleteAllMedia() async {
    print("Deleting all media");
    final db = await database;
    db.rawDelete("Delete from Media");
  }
}