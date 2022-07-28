import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  // Get a location using getDatabasesPath
  static var databasePath;
  static String? path;
  static Database? _database;
  static bool isOpened = false;
  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

  _initDB() async {
    databasePath = await getDatabasesPath();
    path = join(databasePath, 'todo.db');
    print("path:$path");
    return await openDatabase(
      path!,
      version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute(
            'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, startTime TEXT, endTime TEXT, remind TEXT, status TEXT)');
        print("Table created");
      },
    );
  }

  Future<Database> get database async {
    _database ??= await _initDB();
    return _database!;
  }

  Future<bool> insertIntoDB(String title, String date, String startTime,
      String endTime, String remind) async {
    Database database = await instance.database;
    int insertedId = -1;
    try {
      await database.transaction((txn) async {
        int insertedId = await txn.rawInsert(
            'INSERT INTO tasks (title, date, startTime, endTime, remind,status) VALUES (?, ?, ?, ?, ?,?)',
            [title, date, startTime, endTime, remind, 'unCompleted']);

        print('inserted1: $insertedId');
      });
    } catch (e) {
      print(e);
    }

    return insertedId != -1 ? true : false;
  }

  Future<bool> updateRecord(String status, int id) async {
    int count = -1;
    Database database = await instance.database;

    count = await database
        .rawUpdate('UPDATE tasks SET status = ?  WHERE id = ?', [status, id]);
    print('# Updated Records: $count');
    return count != -1 ? true : false;
  }

  Future<List<Map>> getAllRecords(String tableName) async {
    Database database = await instance.database;

    List<Map> list = await database.rawQuery('SELECT * FROM $tableName');
    return list;
  }

  Future<List<Map>> getCompletedRecords(String tableName) async {
    Database database = await instance.database;

    List<Map> list = await database
        .rawQuery('SELECT * FROM $tableName WHERE status = "completed"');
    return list;
  }

  Future<List<Map>> getUncompletedRecords(String tableName) async {
    Database database = await instance.database;

    List<Map> list = await database
        .rawQuery('SELECT * FROM $tableName WHERE status = "unCompleted"');
    return list;
  }

  Future<List<Map>> getFavoriteRecords(String tableName) async {
    Database database = await instance.database;

    List<Map> list = await database
        .rawQuery('SELECT * FROM $tableName WHERE status = "Favorite"');
    return list;
  }

  Future<bool> deleteRecord(int id) async {
    Database database = await instance.database;
    int count =
        await database.rawDelete('DELETE FROM tasks WHERE id = ?', ['$id']);
    print('# Deleted Records: $count');
    return count != -1 ? true : false;
  }

  Future<int> getNumberOfRecords(String tableName) async {
    Database database = await instance.database;

    int? count = Sqflite.firstIntValue(
        await database.rawQuery('SELECT COUNT(*) FROM $tableName'));
    return count!;
  }

  void deleteDB() async {
    await deleteDatabase(path!);
  }
}
