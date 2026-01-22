import 'dart:io';

import 'package:englify_app/services/DB_contrans.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initalDB();
    return _database!;
  }

  Future<Database> _initalDB() async {
    Directory dri = await getApplicationDocumentsDirectory();
    String path = join(dri.path, DBConstants.databaseName);
    return await openDatabase(path, version: 1, onCreate: _createtable);
  }

  Future<void> _createtable(Database db, int version) async {
    await db.execute('''
CREATE TABLE ${DBConstants.userTable} (
${DBConstants.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
${DBConstants.columnEmail} TEXT UNIQUE,
${DBConstants.columnPassword} TEXT,
${DBConstants.columnRole} TEXT 
)
''');
  }

  Future<void> insertuser({
    required String email,
    required String password,
    required String role,
  }) async {
    final db = await database;
    await db.insert(DBConstants.userTable, {
      DBConstants.columnEmail : email,
      DBConstants.columnPassword : password,
      DBConstants.columnRole : role
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> loginUser(
      String email, String password) async {
    final db = await database;

    final result = await db.query(
      DBConstants.userTable,
      where:
          '${DBConstants.columnEmail} = ? AND ${DBConstants.columnPassword} = ?',
      whereArgs: [email, password],
    );

    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }
}
