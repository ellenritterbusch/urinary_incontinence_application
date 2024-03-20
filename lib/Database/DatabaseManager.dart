import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:urinary_incontinence_application/Database/DatabaseModel.dart';
class DatabaseManager{
  static late DatabaseManager _databaseManager;
  static late Database _database;

  String DailyEvaluationTable = 'DailyEvaluation';
  String colDate = 'date';
  String colMemo = 'memo';
  String colEvaluation = 'evaluation';

  DatabaseManager._createInstance();
  factory DatabaseManager(){

    if (_databaseManager== null){
    _databaseManager = DatabaseManager._createInstance();
    }
    return _databaseManager;
  }

  Future <Database> get database async {
    if (_database == null){
      _database = await initializeDatabase();
      return _database;
    }
    else {
      return _database;
    }
  }

   Future <Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path +'dailyevaluation.db';
    var dailyEvaluationDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return dailyEvaluationDatabase;
   }

  void _createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $DailyEvaluationTable($colDate TEXT PRIMARY KEY, $colEvaluation INT, $colMemo TEXT)');
  }
    Future<List<Map<String, dynamic>>> getDailyEvaluationMapList(DatabaseModel dailyEvaluation) async {
      Database db = await this.database;
      var result = await db.rawQuery("SELECT * FROM $DailyEvaluationTable WHERE $colDate = ?", [dailyEvaluation.date]);
      return result;
    }
Future <int> insertDailyEvaluation(DatabaseModel dailyEvaluation) async {
  var db = await this.database;
  var result = await db.update(DailyEvaluationTable, dailyEvaluation.toMap(), where: '$colDate=?', whereArgs: [dailyEvaluation.date]);
  return result;
}
Future <int> deleteDailyEvaluation (String date) async {
  var db = await this.database;
  int result = await db.rawDelete("DELETE FROM $DailyEvaluationTable WHERE $colDate =?", [date]);
  return result;
}
}