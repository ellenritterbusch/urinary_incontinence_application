import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:urinary_incontinence_application/Database/DatabaseModel.dart';
import 'package:path/path.dart'; // Import for joining paths
class DatabaseManager{
  DatabaseManager.privatecontructor();
  static final DatabaseManager databaseManager = DatabaseManager.privatecontructor();
  static Database? database;

//ATTRIBUTES FOR DEFINING TABLE AND COLUMN NAMES
  String DailyEvaluationTable = 'DailyEvaluation';//Used for Daily Evaluation Table
  String BladderDiaryTable = 'BladderDiary';//Used for Bladder Diary Table
  String UserTable = 'User'; //Used for User table'
  String NotificationTable = 'Notification'; //Used for Notifications table

  String colDate = 'date'; //Used for Daily Evaluation AND Bladder Diary Tables
  String colMemo = 'memo';  //Used for Daily Evaluation Table
  String colEvaluation = 'evaluation';//Used for Daily Evaluation Table

  String colAccident = 'accident';//Used for Bladder Diary Table
  String colTime = 'time';//Used for Bladder Diary Table
  String colID = 'id';//Used for Bladder Diary Table
  String colStimType = 'stimtype';//Used for Bladder Diary Table
  String colStimIntensity = 'stimintensity';//Used for Bladder Diary Table
  String colStimTimeSetting = 'stimtimesetting';//Used for Bladder Diary Table

  String colNotiAll = 'allnotification'; //Used for all notifications
  String colNotiDaily = 'dailynotification'; //Used for daily notifications
  String colNotiDemand = 'ondemandnotification'; //Used for ondemand notifications

  String colPIN = 'pin'; // Used for User table




/////// CREATE TABLES ///////
 //CREATE USER TABLE
   Future <Database> get databaseDB async => database ??= await initializeUserDatabase();

   Future <Database> initializeUserDatabase() async { //Constructor for creating database, only used once. 
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path,'p6.db');
    var userDatabase = await openDatabase(path, version: 1, onCreate: _createUDb);
    return userDatabase;
   }

  void _createUDb(Database db, int newVersion) async { //Constructor for creating tables in database. 
    await db.execute('CREATE TABLE $UserTable($colPIN INTEGER PRIMARY KEY)');
    await db.execute('CREATE TABLE $DailyEvaluationTable($colDate STRING PRIMARY KEY, $colEvaluation INTEGER, $colMemo TEXT)');
    await db.execute('CREATE TABLE $BladderDiaryTable($colID INTEGER PRIMARY KEY AUTOINCREMENT, $colDate STRING, $colTime STRING, $colAccident INTEGER)');
    await db.execute('CREATE TABLE $NotificationTable($colNotiAll INTEGER PRIMARY KEY, $colNotiDaily INTEGER, $colNotiDemand INTEGER)');
    
  }


/////// CRUD DAILY EVALUATION ///////
//CREATE
Future <void> insertDailyEvaluation(DatabaseModel data) async {
  Database db = await databaseManager.databaseDB;
  await db.insert('DailyEvaluation', data.toMapDE(),conflictAlgorithm: ConflictAlgorithm.replace);
}
//RETRIEVE
  Future<List<Map<String, dynamic>>> getDailyEvaluations() async {
    Database db = await databaseDB;
    return await db.query(DailyEvaluationTable);
  }

  
//UPDATE
Future <int> updateDailyEvaluation (DatabaseModel dailyEvaluation) async {
  Database db = await databaseManager.databaseDB;
  var res = await db.update(DailyEvaluationTable, dailyEvaluation.toMapDE(), where :'$colDate= ?', whereArgs:[dailyEvaluation.date]);
  return res;
}
//DELETE 
Future <int> deleteDailyEvaluation (String date) async {
  var db = await databaseManager.databaseDB;
  int res = await db.rawDelete("DELETE FROM $DailyEvaluationTable WHERE $colDate =?", [date]);
  return res;
}


/////// CRUD BLADDER DIARY ///////
//CREATE
Future <void> insertBladderDiary(DatabaseModel data) async {
  Database db = await databaseManager.databaseDB;
  await db.insert('BladderDiary', data.toMapBD(),conflictAlgorithm: ConflictAlgorithm.replace);
}
//RETRIEVE
  Future<List<Map<String, dynamic>>> getBladderDiary() async {
    Database db = await databaseDB;
    return await db.query(BladderDiaryTable);
  }
//UPDATE
Future <int> updateBladderDiary (DatabaseModel bladderDiary) async {
  Database db = await databaseManager.databaseDB;
  var res = await db.update(BladderDiaryTable, bladderDiary.toMapBD(), where :'$colID= ?', whereArgs:[bladderDiary.id]);
  return res;
}
//DELETE 
Future <int> deleteBladderDiary (int id) async {
  var db = await databaseManager.databaseDB;
  int res = await db.rawDelete("DELETE FROM $BladderDiaryTable WHERE $colID =?", [id]);
  return res;
}


/////// CRUD USER ///////
//CREATE
Future <void> insertPIN(DatabaseModel data) async {
  Database db = await databaseManager.databaseDB;
  await db.insert('User', data.toMapUser(),conflictAlgorithm: ConflictAlgorithm.replace);
}
//RETRIEVE
  Future<List<Map<String, dynamic>>> getPIN() async {
    Database db = await databaseDB;
    return await db.query(UserTable);
  }
//UPDATE
Future <int> updatePIN (DatabaseModel user) async {
  Database db = await databaseManager.databaseDB;
  var res = await db.update(UserTable, user.toMapUser(), where :'$colPIN= ?', whereArgs:[user.PIN]);
  return res;
}
//DELETE 
Future <int> deletePIN (int PIN) async {
  var db = await databaseManager.databaseDB;
  int res = await db.rawDelete("DELETE FROM $UserTable WHERE $colPIN =?", [PIN]);
  return res;
}


/////// CRUD Notifications ///////
//CREATE ALL
Future <void> insertAllNotification(DatabaseModel data) async {
  Database db = await databaseManager.databaseDB;
  await db.insert('Notification', data.toMapNoti(),conflictAlgorithm: ConflictAlgorithm.replace);
}
//CREATE Daily
Future <void> insertDailyNotification(DatabaseModel data) async {
  Database db = await databaseManager.databaseDB;
  await db.insert('Notification', data.toMapNoti(),conflictAlgorithm: ConflictAlgorithm.replace);
}
//CREATE demand
Future <void> insertDemandNotification(DatabaseModel data) async {
  Database db = await databaseManager.databaseDB;
  await db.insert('Notification', data.toMapNoti(),conflictAlgorithm: ConflictAlgorithm.replace);
}
//RETRIEVE aLL
  Future<List<Map<String, dynamic>>> getAllNotification() async {
    Database db = await databaseDB;
    return await db.query(NotificationTable);
  }
  //RETRIEVE Daily
  Future<List<Map<String, dynamic>>> getDailyNotification() async {
    Database db = await databaseDB;
    return await db.query(NotificationTable);
  }
  //RETRIEVE ON DEMAND
  Future<List<Map<String, dynamic>>> getOnDemandNotification() async {
    Database db = await databaseDB;
    return await db.query(NotificationTable);
  }
//UPDATE ALL
Future <int> updateAllNotification (DatabaseModel allnotification) async {
  Database db = await databaseManager.databaseDB;
  var res = await db.update(NotificationTable, allnotification.toMapNoti(), where :'$colNotiAll= ?');
  return res;
}
//UPDATE Daily
Future <int> updateDailyNotification (DatabaseModel dailynotification) async {
  Database db = await databaseManager.databaseDB;
  var res = await db.update(NotificationTable, dailynotification.toMapNoti(), where :'$colNotiDaily= ?');
  return res;
}
//UPDATE ON DEMAND
Future <int> updateOnDemandNotification (DatabaseModel demandnotification) async {
  Database db = await databaseManager.databaseDB;
  var res = await db.update(NotificationTable, demandnotification.toMapNoti(), where :'$colNotiDemand= ?');
  return res;
}
//DELETE 
Future <int> deleteNotification (int notifi) async {
  var db = await databaseManager.databaseDB;
  int res = await db.rawDelete("DELETE FROM $NotificationTable WHERE $colNotiAll =?", [notifi]);
  return res;
}

}
