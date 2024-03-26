// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print, await_only_futures

// import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        username TEXT,
        email TEXT,
        password TEXT,
        phone TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<sql.Database> db() async {
    // await WidgetsFlutterBinding.ensureInitialized();
    sql.databaseFactory = databaseFactoryFfiWeb;
    return sql.openDatabase(
      'mydata.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> insertData(
      String username, String email, String password, String? phone) async {
    final db = await SQLHelper.db();

    final data = {
      'username': username,
      'email': email,
      'password': password,
      'phone': phone
    };
    final id = await db.insert('users', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await SQLHelper.db();
    return db.query('users', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getUser(int id) async {
    final db = await SQLHelper.db();
    return db.query('users', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<List<Map<String, dynamic>>> searchUser(
      String email, String password) async {
    final db = await SQLHelper.db();
    var data = await db.query('users',
        where: "email = ? AND password = ?",
        whereArgs: [email, password],
        limit: 1);
    String _email = data[0]["email"] as String;
    String _password = data[0]["password"] as String;
    return [
      {'email': _email, 'password': _password}
    ];
  }

  static Future<int> updateData(int id, String username, String email,
      String password, String? phone) async {
    final db = await SQLHelper.db();

    final data = {
      'username': username,
      'email': email,
      'password': password,
      'phone': phone,
      'createdAt': DateTime.now().toString()
    };
    final result =
        await db.update('users', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteUser(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("users", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      print("Something went wrong when deleting an item: $err");
    }
  }
}
