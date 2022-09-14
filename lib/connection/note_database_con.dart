import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/note_model.dart';

const String Id = 'noteId';
const String title = 'noteTitle';
const String catagery = 'noteCatagery';
const String body = 'noteBody';
const String date = 'noteDate';
const String noteTable = 'noteTable';

class NotesDatabaseCon {
  Future<Database> initializeNoteData() async {
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
            'CREATE TABLE $noteTable($Id INTEGER PRIMARY KEY, $title TEXT,$catagery TEXT,$body TEXT,$date TEXT)');
      },
    );
  }

  Future<void> inserNoteData(Notes notes) async {
    var db = await initializeNoteData();
    await db.insert(noteTable, notes.fromJson());
    print('Note was added');
  }
}
