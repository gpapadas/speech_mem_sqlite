import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Database db;

class DatabaseCreator {
  static const transcriptionTable = 'transcription';
  static const id = 'id';
  static const name = 'name';
  static const datetime = 'datetime';
  static const isDeleted = 'isDeleted';

  static void databaseLog(String functionName, String sql,
      [List<Map<String, dynamic>> selectQueryResult, int insertAndUpdateQueryResult, List<dynamic> params]) {
        print(functionName);
        print(sql);

        if (selectQueryResult != null) {
          print(selectQueryResult);
        } else if (insertAndUpdateQueryResult != null) {
          print(insertAndUpdateQueryResult);
        }
      }
  
  Future<void> createTranscriptionTable(Database db) async {
    final sql = '''CREATE TABLE $transcriptionTable
    (
      $id INTEGER PRIMARY KEY,
      $name TEXT,
      $datetime INTEGER,
      $isDeleted BIT NOT NULL 
    )''';

    await db.execute(sql);
  }

  Future<String> getDatabasePath(String dbName) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);

    // Make sure the folder exists
    if (await Directory(dirname(path)).exists()) {
      // await deleteDatabase(path);
    } else {
      await Directory(dirname(path)).create(recursive: true);
    }

    return path;
  }

  Future<void> initDatabase() async {
    final path = await getDatabasePath('transcription_db');
    db = await openDatabase(path, version: 1, onCreate: onCreate);
    print(db);
  }

  Future<void> onCreate(Database db, int version) async {
    await createTranscriptionTable(db);
  }
}
