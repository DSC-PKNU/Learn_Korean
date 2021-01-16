import 'package:flutter/material.dart';
import 'package:learn_korean_for_children/model/ProblemModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class WrongProblemControllor {
  Future<Database> initDatabase(int stage) async {
    String stageIndex = stage.toString();
    WidgetsFlutterBinding.ensureInitialized();
    Future<Database> database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'wrong_problems_$stageIndex.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE wrong_problems_$stageIndex(id INTEGER PRIMARY KEY, problem STRING)",
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
    return database;
  }

  Future<bool> saveSqlite(int stage, ProblemModel problemModel) async {
    String stageIndex = stage.toString();
    Database db = await initDatabase(stage);
    String problem = problemModel.problem;
    var queryResult = await db.rawQuery(
        'SELECT * FROM wrong_problems_$stageIndex WHERE problem = "$problem"');
    if (queryResult.isEmpty) {
      await db.insert(
          'wrong_problems_$stageIndex', {'problem': problemModel.problem});
      return true;
    } else {
      return false;
    }
  }

  Future<List<ProblemModel>> loadSqlite(int stage) async {
    String stageIndex = stage.toString();
    Database db = await initDatabase(stage);
    List<ProblemModel> problems = [];
    var queryResult =
        await db.rawQuery('SELECT * FROM wrong_problems_$stageIndex');

    queryResult.forEach((element) {
      problems.add(ProblemModel(problem: element['problem']));
    });

    return problems;
  }

  void deleteSqlite(int stage, ProblemModel problem) async {
    String stageIndex = stage.toString();
    String primaryKey = problem.problem;
    Database db = await initDatabase(stage);
    print(await db.rawDelete(
        'DELETE FROM wrong_problems_$stageIndex WHERE problem = "$primaryKey"'));
  }
}
