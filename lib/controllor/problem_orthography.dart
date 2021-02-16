import 'package:flutter/material.dart';
import 'package:learn_korean_for_children/model/OrthographyModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class OrthographyControllor {
  Future<Database> initDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    Future<Database> database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'otho_problems_registered.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE otho_problems_registered(id INTEGER PRIMARY KEY, problem STRING)",
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
    return database;
  }

  Future<bool> saveSqlite(OrthographyModel problemModel) async {
    Database db = await initDatabase();
    String problem = problemModel.problem;
    var queryResult = await db.rawQuery(
        'SELECT * FROM otho_problems_registered WHERE problem = "$problem"');
    if (queryResult.isEmpty) {
      await db.insert(
          'otho_problems_registered', {'problem': problemModel.problem});
      return true;
    } else {
      return false;
    }
  }

  Future<List<OrthographyModel>> loadSqlite() async {
    Database db = await initDatabase();
    List<OrthographyModel> problems = [];
    var queryResult =
        await db.rawQuery('SELECT * FROM otho_problems_registered');

    queryResult.forEach((element) {
      problems.add(OrthographyModel(problem: element['problem']));
    });

    return problems;
  }

  void deleteSqlite(OrthographyModel problem) async {
    String primaryKey = problem.problem;
    Database db = await initDatabase();
    print(await db.rawDelete(
        'DELETE FROM otho_problems_registered WHERE problem = "$primaryKey"'));
  }

  Future<bool> modifySqlite(
      OrthographyModel problemModel, String newProblem) async {
    Database db = await initDatabase();
    String problem = problemModel.problem;
    var queryResult = await db.rawQuery(
        'SELECT * FROM otho_problems_registered WHERE problem = "$problem"');

    await db.update('otho_problems_registered', {'problem': newProblem},
        where: 'problem = ?', whereArgs: [problemModel.problem]);
    return true;
  }
}