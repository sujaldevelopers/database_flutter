import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import 'note class.dart';

class NoteDatabase {
  // private constructor
  NoteDatabase._init();

  //Instance
  static NoteDatabase instance = NoteDatabase._init();

  //Private Database
  Database? _database;

  //Database init
  Future<Database> get database async => instance._database ?? await _initDB();

  Future<Database> _initDB() async {
    final myPath = await getDatabasesPath();
    final path = "$myPath/note.db";
    final database = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    _database = database;
    return database;
  }

//Table Name
  String _tableName = "MyNewNote";

  Future<void> _onCreate(
    Database db,
    int version,
  ) async {
    await db.execute("""
    CREATE TABLE $_tableName (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
     
      desc TEXT NOT NULL,
      date TEXT NOT NULL,
      done BOOLEAN NOT NULL
    )
""");
  }

//Create Database
  Future<int> createNote(Note note) async {
    debugPrint("createData : ${note.toJson()}");
    final db = await instance.database;
    final id = await db.insert(_tableName, note.toJson());
    debugPrint("createDataID : $id");
    return id;
  }

//SingleNote
  Future<Note?> singleNote(int id) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> notes = await db.query(
      _tableName,
      where: "id=?",
      whereArgs: [id],
    );
    if(notes.isNotEmpty){
      return Note.fromJson(notes.first);
    }else
      {
        return null;
      }
  }

//ReadData
  Future<List<Note>> readnote() async {
    final db = await instance.database;
    final List<Map<String, Object?>> notes = await db.query(_tableName);
    final list = List<Note>.from(notes.map((e) => Note.fromJson(e)));
    return list;
  }

//Update
  Future<int> updatenote(Note note) async {
    final db = await instance.database;
    final id = await db.update(
      _tableName,
      note.toJson(),
      where: "id=?",
      whereArgs: [note.id],
    );
    return id;
  }

//Delete
  Future<int> deletenote(int id) async {
    final db = await instance.database;
    final i = await db.delete(
      _tableName,
      where: "id=?",
      whereArgs: [id],
    );
    return i;
  }
}
