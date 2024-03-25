import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:urinary_incontinence_application/Database/DatabaseModel.dart';
import 'package:flutter/material.dart';
class DatabaseManager{
  DatabaseManager.privatecontructor();
  static final DatabaseManager databaseManager = DatabaseManager.privatecontructor();
  static Database? database;

//ATTRIBUTES FOR DEFINING TABLE AND COLUMN NAMES
  String DailyEvaluationTable = 'DailyEvaluation';
  String colDate = 'date';
  String colMemo = 'memo';
  String colEvaluation = 'evaluation';


  Future <Database> get databaseDB async => database ??= await initializeDatabase();

   Future <Database> initializeDatabase() async { //Constructor for creating database, only used once. 
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path +'dailyevaluation.db';
    var dailyEvaluationDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return dailyEvaluationDatabase;
   }

  void _createDb(Database db, int newVersion) async { //Constructor for creating tables in database. 
    await db.execute('CREATE TABLE $DailyEvaluationTable($colDate INTEGER PRIMARY KEY, $colEvaluation INT, $colMemo TEXT)');
  }
  //RETRIEVE DATA FROM DATABASE
  Future<List<Map<String, dynamic>>> getDailyEvaluationMapList(DatabaseModel dailyEvaluation) async { //
      Database db = await databaseManager.databaseDB;
      var res = await db.rawQuery("SELECT * FROM $DailyEvaluationTable WHERE $colDate = ?", [dailyEvaluation.date]);
      return res;
    }
    //UPDATE VALUES IN DATABASE
Future <int> updateDailyEvaluation (DatabaseModel dailyEvaluation) async {
  Database db = await databaseManager.databaseDB;
  var res = await db.update(DailyEvaluationTable, dailyEvaluation.toMap(), where :'$colDate= ?', whereArgs:[dailyEvaluation.date]);
  return res;
}
//INSERT NEW VALUES IN DATABASE
Future <void> insertDailyEvaluation(DatabaseModel data) async {
  Database db = await databaseManager.databaseDB;
  await db.insert('DailyEvaluation', data.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);

}
//DELETE VALUES IN DATABASE
Future <int> deleteDailyEvaluation (String date) async {
  var db = await databaseManager.databaseDB;
  int res = await db.rawDelete("DELETE FROM $DailyEvaluationTable WHERE $colDate =?", [date]);
  return res;
}
}

void read() async {
  //final evaluation = await DatabaseManager.getDailyEvaluationMapList();
 // evaluation.forEach((row)=>print(row));
} 

 // DatabaseManager._createInstance();
 // factory DatabaseManager(){ //Used to create _databaseManager for the first time, which is then used from then on. 

  //   if (_databaseManager== null){
  //   _databaseManager = DatabaseManager._createInstance();
  //   }
  //   return _databaseManager;
  // }