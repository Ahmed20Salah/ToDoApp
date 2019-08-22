import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:todo_app/models/task.dart';

class TasksDatabase {
  static final TasksDatabase _instnace = TasksDatabase.internal();
  TasksDatabase.internal();
  factory TasksDatabase() => _instnace;
  Database _db;
  final String tableName = 'tasktable';
  final String columnId = 'id';
  final String columnName = 'name';
  final String columnDescription = 'description';
  final String columnDay = 'day';
  final String columnCode = 'code';
  final String columnStatus = ' status';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  initDb() async {
    Directory documentdirectory = await getApplicationDocumentsDirectory();
    String path = join(documentdirectory.path, "main.db");
    var ourDb = openDatabase(path, onCreate: _onCreate, version: 1);
    return ourDb;
  }

  _onCreate(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY , $columnName TEXT , $columnDescription TEXT , $columnDay TEXT , $columnStatus BOOL , $columnCode TEXT)");
  }

  // insert function
  Future<int> insertTask(TaskModel data) async {
    Map<String, dynamic> task = {
      'name': data.name,
      'description': data.description,
      'day': data.day,
      'id': data.id,
      'status': false
    };
    var ourdb = await db;
    var res = ourdb.insert('$tableName', task);
    return res;
  }

  // get data from database
  Future<List<Map<String, dynamic>>> getAllTasks() async {
    var ourdb = await db;
    var res = await ourdb.rawQuery('SELECT * FROM $tableName ');
    return res;
  }

  // delete Function
  Future<int> deleteTask(int id) async {
    var ourdb = await db;
    var res =
        await ourdb.delete(tableName, where: "$columnId = ?", whereArgs: [id]);
    return res;
  }

  //  upadata function
  Future<int> update(TaskModel data) async {
    Map<String, dynamic> task = {
      'name': data.name,
      'description': data.description,
      'day': data.day,
      'id': data.id,
      'status': false
    };
    var our_db = await db;
    var res = await our_db
        .update(tableName, task, where: "$columnId =? ", whereArgs: [data.id]);
  }
}
