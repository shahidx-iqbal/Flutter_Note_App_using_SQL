import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import 'models/note.dart';

class DBHelper {

  final String tableName = "notes";
  final String id = "id";
  final String title = "title";
  final String description = "description";
  final String email = "email";
  final String date = "date";


  static Database? _db;
  Future<Database?> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDatabase();
    return _db!;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'record.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate );
    return db;
  }

  _onCreate(Database db, int version) async {

    await  db.execute(
        'CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, description TEXT NOT NULL, email TEXT NOT NULL, date TEXT NOT NULL)'
        //     "CREATE TABLE $tableName("
        //     "$id INTEGER UNIQUE, "
        //     "$title TEXT NOT NULL, "
        //     "$description Text NOT NULL, "
        //     "$email Text NOT NULL, "
        //     "$date TEXT NOT NULL," ")"
    );

  }


  Future<NotesModel> insert(NotesModel notesModel) async {
    var dbClient = await db;
    await dbClient!.insert( tableName , notesModel.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    return notesModel;
  }

  Future<List<NotesModel>> getCartListWithUserId() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult = await dbClient!.query(tableName);
    return queryResult.map((e) => NotesModel.fromMap(e)).toList();
  }


  Future deleteTableContent() async {
    var dbClient = await db;
    return await dbClient!.delete(
      tableName,
    );
  }


  Future<int> updateQuantity(NotesModel notesModel) async {
    var dbClient = await db;
    return await dbClient!.update(
      tableName,
      notesModel.toMap(),
      where: 'id = ?',
      whereArgs: [notesModel.id],
    );
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    var dbClient = await db;
    dbClient!.close();
  }


}