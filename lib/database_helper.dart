import 'dart:io';

import 'package:flutter/material.dart';
import 'package:income_splitter/models/category.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static final _databaseName = "IncomeSplitter.db";
  static final _databaseVersion = 1;
  static final _table = 'category';

  static final columnId = '_id';
  static final columnName = 'name';
  static final columnPercent = 0;

  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path, version: _databaseVersion,
    onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Category ("
          "id INTEGER PRIMARY KEY,"
          "category_name TEXT,"
          "category_percentage INT"
          ")");
    });
  }

  newClient(Category newCategory) async {
    final db = await database;
    var res = await db.insert(_table, newCategory.toMap());
    return res;
  }
}
