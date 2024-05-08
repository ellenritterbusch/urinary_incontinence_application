

class DatabaseModel {

 late int? dailyEvaluationScore;
 late String? dailyEvaluationMemo;
 late String? date;
 late int? accident;
 late String? time;
 late int? stimType;
 late int? stimIntensity;
 late int? stimTimeSetting;
 late int? id;
 late int? PIN;
 late int? noti_id;
 late int? noti_all;
 late int? noti_eva;
 late int? noti_ondemand;

DatabaseModel.DE(this.dailyEvaluationScore, this.dailyEvaluationMemo, this.date);
DatabaseModel.BD(this.date, this.time, this.accident, this.stimType, this.stimTimeSetting);
DatabaseModel.User(this.PIN);
DatabaseModel.Noti(this.noti_id, this.noti_all, this.noti_eva, this.noti_ondemand);



/// TO/FROM MAP FOR DAILY EVALUATION
  Map<String,dynamic> toMapDE(){
    var map = Map<String, dynamic>();
    map['evaluation'] = dailyEvaluationScore;
    map['memo'] = dailyEvaluationMemo;
    map['date'] = date;
    return map;
  }
  DatabaseModel.fromMapObjectDE(Map<String,dynamic> map){
    this.dailyEvaluationScore= map['evaluation'];
    this.dailyEvaluationMemo = map['memo'];
    this.date = map['date'];
  }

  /// TO/FROM MAP FOR BLADDER DIARY
  Map<String,dynamic> toMapBD(){
    var map = Map<String, dynamic>();
    map['accident'] = accident;
    map['time'] = time;
    map['date'] = date;
   map['stimtype']= stimType;
    //map ['stimintensity']= stimIntensity;
   map ['stimtimesetting'] = stimTimeSetting;
    return map;
  }
  DatabaseModel.fromMapObjectBD(Map<String,dynamic> map){
    accident = map['accident'];
    time = map['time'];
    date = map['date'];
    stimType = map['stimtype'];
    stimIntensity = map ['stimintensity'];
    stimTimeSetting = map ['stimtimesetting'];

  }
   Map<String,dynamic> toMapFakeData(){
    var map = Map<String, dynamic>();
    map['accident'] = accident;
    map['time'] = time;
    map['date'] = date;
    map['stimtype']= stimType;
    map ['stimtimesetting'] = stimTimeSetting;
    return map;
  }
  
  /// TO/FROM MAP FOR USER
  Map<String,dynamic> toMapUser(){
    var map = Map<String, dynamic>();
    map['pin'] = PIN;
    return map;
  }
  DatabaseModel.fromMapObjectUser(Map<String,dynamic> map){
    this.PIN= map['pin'];
  }

  ///TO/FROM MAP FOR NOTI
    Map<String,dynamic> toMapNoti(){
    var map = Map<String, dynamic>();
    map['notificationID'] = noti_id;
    map['allnotification'] = noti_all;
    map['dailynotification'] = noti_eva;
    map['ondemandnotification'] = noti_ondemand;
    return map;
  }
  DatabaseModel.fromMapObjectNoti(Map<String,dynamic> map){
    this.noti_id= map['notificationID'];
    this.noti_all= map['allnotification'];
    this.noti_eva= map['dailynotification'];
    this.noti_ondemand = map['ondemandnotification'];
  }
}


