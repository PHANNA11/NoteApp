import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

import '../models/user_model.dart';

String tableUser = 'userDb';
String mailField = 'email';

class UserDatabaseCon {
  Future<Database> initializeUserData() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'data.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE $tableUser(id INTEGER PRIMARY KEY, userName TEXT,$mailField TEXT,password TEXT)');
      },
    );
  }

  Future<void> insertUserData(User user) async {
    var db = await initializeUserData();
    await db.insert(tableUser, user.fromJson());
    print('object was insert');
  }

  Future<User> userLoginData(String email, String password) async {
    var db = await initializeUserData();
    var res = await db.rawQuery(
        "SELECT * FROM $tableUser WHERE $mailField='$email' AND password='$password'");
    if (res.length > 0) {
      return User.toJson(res.first);
    }
    return User.toJson(res.first);
  }
}
