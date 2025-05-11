import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'users.dart';

class MyCodeOperation {
  MyCodeOperation._privateConstructor();
  static final MyCodeOperation instance = MyCodeOperation._privateConstructor();

  final String databaseName = "MyCodeDatabase";

  final String createTableQuery = '''
CREATE TABLE users(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  Number TEXT,
  Code TEXT
)
''';

  Future<Database> initializeDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(createTableQuery);
      },
    );
  }

  Future<MyCode?> loginUser(MyCode usr) async {
    final Database db = await initializeDb();
    final result = await db.rawQuery(
      "SELECT * FROM users WHERE Number = ? AND Code = ?",
      [usr.Number, usr.Code],
    );

    if (result.isNotEmpty) {
      return MyCode.fromMap(result.first);
    }
    return null;
  }

  Future<int> createUser(MyCode usr) async {
    final Database db = await initializeDb();
    return db.rawInsert(
      "INSERT INTO users (Number, Code) VALUES (?, ?)",
      [usr.Number, usr.Code],
    );
  }

  Future<int> deleteUserByNumber(String number) async {
    final Database db = await initializeDb();
    return await db.rawDelete('DELETE FROM users WHERE Number = ?', [number]);
  }

  Future<bool> checkUserExists(String number) async {
    final Database db = await initializeDb();
    final result = await db.rawQuery(
      "SELECT * FROM users WHERE Number = ?",
      [number],
    );
    return result.isNotEmpty;
  }

  Future<void> updateUser(MyCode usr) async {
    final Database db = await initializeDb();
    await db.update(
      'users',
      usr.toMap(),
      where: "id = ?",
      whereArgs: [usr.id],
    );
  }

  Future<List<MyCode>> getAllUsers() async {
    final Database db = await initializeDb();
    final List<Map<String, dynamic>> list = await db.rawQuery('SELECT * FROM users');
    return list.map((usr) => MyCode.fromMap(usr)).toList();
  }

  Future<List<MyCode>> searchUser(String query) async {
    final Database db = await initializeDb();
    final List<Map<String, dynamic>> result = await db.rawQuery(
        "SELECT * FROM users WHERE Number = ?", [query]
    );
    return result.map((user) => MyCode.fromMap(user)).toList();
  }
}