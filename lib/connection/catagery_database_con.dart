import 'dart:io';

import 'package:note_app1/models/catagery_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

String catageryTable = 'CatageryTable';
String fCatageryId = 'CatageryId';
String fCatageryName = 'CatageryName';

class CatageryDatabaseCon {
  Future<Database> initializeCatageryData() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'catageryTabledb.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE $catageryTable($fCatageryId INTEGER PRIMARY KEY, $fCatageryName TEXT)');
      },
    );
  }

  Future<void> inserCatageryData(CatageryModel catageryModel) async {
    var db = await initializeCatageryData();
    await db.insert(catageryTable, catageryModel.fromJson());
    print('Catagery was added');
  }

  Future<List<CatageryModel>> readCatageryData() async {
    var db = await initializeCatageryData();
    List<Map<String, dynamic>> result = await db.query(catageryTable);
    return result.map((e) => CatageryModel.toJson(e)).toList();
  }

  Future<void> deleteCatagery(int catageryId) async {
    var db = await initializeCatageryData();
    await db.delete(catageryTable,
        where: '$fCatageryId=?', whereArgs: [catageryId]);
  }

  Future<void> updateCatagery(CatageryModel catageryModel) async {
    var db = await initializeCatageryData();
    await db.update(catageryTable, catageryModel.fromJson(),
        where: '$fCatageryId=?', whereArgs: [catageryModel.CatageryId]);
  }
}
