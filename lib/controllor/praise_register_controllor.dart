import 'package:flutter/material.dart';
import 'package:learn_korean_for_children/model/ProblemModel.dart';
import 'package:learn_korean_for_children/page_class/PrarentPraise.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class PraiseModel {
  PraiseModel({this.praise, this.stage});
  String praise;
  int stage;
}

class PraiseRegistControllor {
  Future<Database> initDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    Future<Database> database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'praise_registered.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE praise_registered(id INTEGER PRIMARY KEY, stage INTEGER, praise STRING)",
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
    return database;
  }

  Future<bool> saveSqlite(PraiseModel praiseModel) async {
    Database db = await initDatabase();
    int stage = praiseModel.stage;
    String praise = praiseModel.praise;
    var queryResult = await db
        .rawQuery('SELECT * FROM praise_registered WHERE stage = "$stage"');
    if (queryResult.isEmpty) {
      await db.insert('praise_registered', {'stage': stage, 'praise': praise});
      return true;
    } else {
      await db.update('praise_registered', {'stage': stage, 'praise': praise},
          where: 'stage = ?', whereArgs: [stage]);
      return false;
    }
  }

  Future<List<PraiseModel>> loadSqlite() async {
    Database db = await initDatabase();
    List<PraiseModel> praiseModels = [];
    var queryResult = await db.rawQuery('SELECT * FROM praise_registered');

    queryResult.forEach((element) {
      praiseModels
          .add(PraiseModel(praise: element['praise'], stage: element['stage']));
    });

    return praiseModels;
  }

  Future<PraiseModel> loadEachSqlite(int stage) async {
    Database db = await initDatabase();
    List<PraiseModel> praiseModels = [];
    var queryResult = await db.rawQuery('SELECT * FROM praise_registered');

    queryResult.forEach((element) {
      praiseModels
          .add(PraiseModel(praise: element['praise'], stage: element['stage']));
    });

    return praiseModels.firstWhere((element) {
          return element.stage == stage;
        }) ??
        '';
  }

  void deleteSqlite(PraiseModel praise) async {
    int primaryKey = praise.stage;
    Database db = await initDatabase();
    print(await db.rawDelete(
        'DELETE FROM praise_registered WHERE stage = "$primaryKey"'));
  }
}
