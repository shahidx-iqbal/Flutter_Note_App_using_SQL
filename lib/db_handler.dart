import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'models/note.dart';



class DBHelper {
  static Database? _db;

  String noteTable = 'note_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colPriority = 'priority';
  String colDate = 'date';


  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}notes.db';
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(

        'CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
            '$colDescription TEXT, $colPriority INTEGER, $colDate TEXT)'

//      "CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT NOT NULL,description TEXT NOT NULL,date TEXT NOT NULL,priority INTEGER NOT NULL)",
    );
  }

  //insert data to SQl database

  Future<NotesModel> insert(NotesModel notesModel) async {
    var dbClient = await db;
    await dbClient!.insert( noteTable, notesModel.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
    return notesModel;
  }

  Future<List<NotesModel>> getNoteLists() async{
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult = await dbClient!.query(noteTable);
      return queryResult.map((e) => NotesModel.fromMap(e)).toList();
  }

}


